#!/usr/bin/python

# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: create_file

short_description: This is module creates file.

version_added: "1.0.0"

description: The module creates a file if it does not exist and updates it if the file exists and the contents differ from the specified one.

options:
    path:
        description: Path to file.
        required: true
        type: str
    content:
        description: what should be in the file
        required: true
        type: str

author:
    - Vladislav Shishkov (@cachmc)
'''

EXAMPLES = r'''
- name: New file
  cachmc.create_file:
    path: /tmp/new_file.txt
    content: |
      Hello, world!
'''

RETURN = r'''
message:
    description: File status.
    type: str
    returned: always
    sample: 'Create file {{ path }}'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True)
    )

    result = dict(
        changed=False,
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    ### Check mpde logic
    if module.check_mode:
        try:
            check_file = open(module.params["path"], 'r')
            check_file.close()
        except IOError as e:
            try:
                file = open(module.params["path"], 'w')
            except IOError as e:
                module.fail_json(msg=str(e), **result)
            else:
                with file:
                    result['changed'] = True
                    result['message'] = 'Created file {}'.format(module.params['path'])
        else:
            with open(module.params["path"], 'r') as file:
                origin_content = file.read()
                if origin_content != module.params["content"]:
                    try:
                        file = open(module.params["path"], 'w')
                    except IOError as e:
                        module.fail_json(msg=str(e), **result)
                    else:
                        with file:
                            result['changed'] = True
                            result['message'] = 'Updated file {}'.format(module.params['path'])
                else:
                    result['message'] = 'File exists {}'.format(module.params['path'])
        module.exit_json(**result)

    ### Main logic
    try:
        check_file = open(module.params["path"], 'r')
        check_file.close()
    except IOError as e:
        try:
            file = open(module.params["path"], 'w')
        except IOError as e:
            module.fail_json(msg=str(e), **result)
        else:
            with file:
                file.write(module.params["content"])
                result['changed'] = True
                result['message'] = 'Created file {}'.format(module.params['path'])
    else:
        with open(module.params["path"], 'r') as file:
            origin_content = file.read()
            if origin_content != module.params["content"]:
                try:
                    file = open(module.params["path"], 'w')
                except IOError as e:
                    module.fail_json(msg=str(e), **result)
                else:
                    with file:
                        file.write(module.params["content"])
                        result['changed'] = True
                        result['message'] = 'Updated file {}'.format(module.params['path'])
            else:
                result['message'] = 'File exists {}'.format(module.params['path'])
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
