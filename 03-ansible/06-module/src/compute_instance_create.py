#!/usr/bin/python

# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: compute_instance_create

short_description: This is module creates compute instance in Yandex Cloud.

version_added: "1.0.0"

description: The module searches for a match in Yandex Cloud by the host name from inventory. If there is no such host in YC, it creates it. The received IP address is written to the variable 'ansible_host'. The module must be launched on localhost.

options:
    iam_token:
        description: token for connecting to YC
        required: true
        type: str
    folder_id:
        description: folder in which it will be created compute instance
        required: true
        type: str
    name:
        description: hostname for compute instance
        required: true
        type: str
    image:
        description: image data for installation
        required: false
        type: dict
        options:
            folder_family_id:
                description: ID of the folder the images are in
                required: false
                type: str
                default: standard-images
            family:
                description: image family ID
                required: false
                type: str
                default: ubuntu-2204-lts
    resources:
        description: resources data compute instance
        required: false
        type: dict
        options:
            platform_id:
                description: platform ID
                required: false
                type: str
                default: standard-v3
            cores:
                description: count CPU
                required: false
                type: int
                default: 2
            memory:
                description: size RAM
                required: false
                type: int
                default: 2147483648
            disk:
                description: disk data compute instance
                required: false
                type: dict
                options:
                    type:
                        description: type disk
                        required: false
                        type: str
                        default: network-hdd
                    size:
                        description: size disk
                        required: false
                        type: int
                        default: 10737418240
            network:
                description: network data compute instance
                required: false
                type: dict
                options:
                    zone:
                        description: network zone 
                        required: false
                        type: str
                        default: ru-central1-a
                    subnet_id:
                        description: subnet ID in network zone
                        required: true
                        type: str
    ssh_user:
        description: user for ssh connection
        required: true
        type: str
    ssh_public_key:
        description: puplic key for ssh connection
        required: true
        type: str

author:
    - Vladislav Shishkov (@cachmc)
'''

EXAMPLES = r'''
- name: Create host
  yandex_cloud_compute_instance_create:
    iam_token: "i0987654w34qawesdfghuio0iugf45ecrtvy"
    folder_id: "nsbc7shmwkw938u3jd"
    name: "{{ ansible_host }}"
    resources:
      cores: 4
      network:
        subnet_id: "87sbn3jt76ftsboqsoknb"
    ssh_user: "ubuntu"
    ssh_public_key: "ssh-ed25519 HSYUAINBHVADSBX7162etdghqaASDAnalI&TGQUasdDSJQ"
  delegate_to: localhost
'''

RETURN = r'''
message:
    description: Status aboute compute instance
    type: str
    returned: always
    sample: 'Instance with name {{ name }} was created'
local_ip_address:
    description: Local IP address compute instance
    type: str
    returned: always
    sample: '10.0.1.10'
external_ip_address:
    description: External IP address compute instance
    type: str
    returned: success
    sample: '159.11.12.13'
'''

from ansible.module_utils.basic import AnsibleModule

import grpc
import yandexcloud
from yandex.cloud.compute.v1.image_service_pb2 import GetImageLatestByFamilyRequest
from yandex.cloud.compute.v1.image_service_pb2_grpc import ImageServiceStub
from yandex.cloud.compute.v1.instance_pb2 import IPV4, Instance
from yandex.cloud.compute.v1.instance_service_pb2 import (
    AttachedDiskSpec,
    CreateInstanceMetadata,
    CreateInstanceRequest,
    ListInstancesRequest,
    NetworkInterfaceSpec,
    OneToOneNatSpec,
    PrimaryAddressSpec,
    ResourcesSpec,
)
from yandex.cloud.compute.v1.instance_service_pb2_grpc import InstanceServiceStub
from google.protobuf.json_format import MessageToDict

def run_module():
    module_args = dict(
        iam_token=dict(type='str', required=True),
        folder_id=dict(type='str', required=True),
        name=dict(type='str', required=True),
        image=dict(
            type='dict',
            required=False,
            default=dict(
                folder_family_id='standard-images',
                family='ubuntu-2204-lts'
            ),
            options=dict(
                folder_family_id=dict(type='str', required=False, default='standard-images'),
                family=dict(type='str', required=False, default='ubuntu-2204-lts'),
            ),
        ),
        resources=dict(
            type='dict',
            required=False,
            default=dict(
                platform_id='standard-v3',
                cores='2',
                memory='2147483648',
                disk=dict(
                    type='network-hdd',
                    size='10737418240'
                ),
                network=dict(
                    zone='ru-central1-a'
                )
            ),
            options=dict(
                platform_id=dict(type='str', required=False, default='standard-v3'),
                cores=dict(type='int', required=False, default='2'),
                memory=dict(type='int', required=False, default='2147483648'),
                disk=dict(
                    type='dict',
                    required=False,
                    default=dict(
                        type='network-hdd',
                        size='10737418240'
                    ),
                    options=dict(
                        type=dict(type='str', required=False, default='network-hdd'),
                        size=dict(type='int', required=False, default='10737418240'),
                    ),
                ),
                network=dict(
                    type='dict',
                    required=False,
                    default=dict(
                        zone='ru-central1-a'
                    ),
                    options=dict(
                        zone=dict(type='str', required=False, default='ru-central1-a'),
                        subnet_id=dict(type='str', required=True),
                    ),
                ),
            ),
        ),
        ssh_user=dict(type='str', required=True),
        ssh_public_key=dict(type='str', required=True),
    )

    result = dict(
        changed=False,
        message="",
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=False
    )

    ### Main logic
    # Setting up the interceptor for retries
    interceptor = yandexcloud.RetryInterceptor(max_retry_count=5, retriable_codes=[grpc.StatusCode.UNAVAILABLE])
    sdk = yandexcloud.SDK(interceptor=interceptor, iam_token=module.params['iam_token'])

    # Getting list of instances
    try:
        instance_service = sdk.client(InstanceServiceStub)
        response = instance_service.List(
            ListInstancesRequest(
                folder_id=module.params['folder_id'],
            ),
        )
        list_instances = MessageToDict(response)

        for instance in list_instances['instances']:
            if instance['name'] == module.params['name']:
                if instance['networkInterfaces'][0]['primaryV4Address']['oneToOneNat'].get('address', False) != False:
                    result['external_ip_address'] = instance['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address']
                result['local_ip_address'] = instance['networkInterfaces'][0]['primaryV4Address']['address']
                result['message'] = "Instance with name '{}' already exists".format(module.params['name'])
                module.exit_json(**result)

        # Preparing metadata
        metadata = {
            "ssh-keys": module.params['ssh_user']+":"+module.params['ssh_public_key'],
            "user-data": "#cloud-config\n    datasource:\n      Ec2:\n        strict_id: false\n    users:\n      - name: {}\n        sudo: 'ALL=(ALL) NOPASSWD:ALL'\n        shell: /bin/bash\n        ssh_authorized_keys:\n          - {}".format(module.params['ssh_user'],module.params['ssh_public_key']),
        }

        # Getting the latest image by family
        try:
            image_service = sdk.client(ImageServiceStub)
            source_image = image_service.GetLatestByFamily(
                GetImageLatestByFamilyRequest(
                    folder_id=module.params['image']['folder_family_id'],
                    family=module.params['image']['family'],
                ),
            )
        except grpc.RpcError as rpc_error:
          module.fail_json(msg=dict(code=str(rpc_error.code()), details=str(rpc_error.details())), **result)

        # Creating a VM instance
        try:
            create_instance = instance_service.Create(
                CreateInstanceRequest(
                    folder_id=module.params['folder_id'],
                    name=module.params['name'],
                    metadata=metadata,
                    resources_spec=ResourcesSpec(
                        memory=module.params['resources']['memory'],
                        cores=module.params['resources']['cores'],
                    ),
                    labels={},
                    zone_id=module.params['resources']['network']['zone'],
                    platform_id=module.params['resources']['platform_id'],
                    boot_disk_spec=AttachedDiskSpec(
                        auto_delete=True,
                        disk_spec=AttachedDiskSpec.DiskSpec(
                            type_id=module.params['resources']['disk']['type'],
                            size=module.params['resources']['disk']['size'],
                            image_id=source_image.id,
                        ),
                    ),
                    network_interface_specs=[
                        NetworkInterfaceSpec(
                            subnet_id=module.params['resources']['network']['subnet_id'],
                            primary_v4_address_spec=PrimaryAddressSpec(
                                one_to_one_nat_spec=OneToOneNatSpec(
                                    ip_version=IPV4,
                                ),
                            ),
                        ),
                    ],
                ),
            )
        except grpc.RpcError as rpc_error:
          module.fail_json(msg=dict(code=str(rpc_error.code()), details=str(rpc_error.details())), **result)

        # Create the operation for creating a VM instance
        operation_result = sdk.wait_operation_and_get_result(
            create_instance,
            response_type=Instance,
            meta_type=CreateInstanceMetadata,
        )

        instance = MessageToDict(operation_result.response)

        if instance['networkInterfaces'][0]['primaryV4Address']['oneToOneNat'].get('address', False) != False:
            result['external_ip_address'] = instance['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address']
        result['local_ip_address'] = instance['networkInterfaces'][0]['primaryV4Address']['address']
        result['message'] = "Instance with name '{}' was created".format(module.params['name'])
        result['changed'] = True
        module.exit_json(**result)

    except grpc.RpcError as rpc_error:
        module.fail_json(msg=dict(code=str(rpc_error.code()), details=str(rpc_error.details())), **result)


def main():
    run_module()


if __name__ == '__main__':
    main()
