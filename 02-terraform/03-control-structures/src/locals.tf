locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")

  #For task 5
  list_vm_db = [ for vm_db in yandex_compute_instance.create_vm_db: vm_db ] 
  list_vm_for_output = setunion(local.list_vm_db, yandex_compute_instance.create_vm_web)

  #For task 7
  vpc = {
    "network_id" = "enp7i560tb28nageq0cc"
    "subnet_ids" = [
      "e9b0le401619ngf4h68n",
      "e2lbar6u8b2ftd7f5hia",
      "b0ca48coorjjq93u36pl",
      "fl8ner8rjsio6rcpcf0h",
    ]
    "subnet_zones" = [
      "ru-central1-a",
      "ru-central1-b",
      "ru-central1-c",
      "ru-central1-d",
    ]
  }
}


