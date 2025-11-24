env_prefix = "netology"

metadata = {
  serial-port-enable = "1"
  ssh-keys           = "ubuntu:ssh-ed25519 AAAA...den@rmq01"
}

vms_resources = {
  web = {
    cores         = 2
    memory        = 2
    core_fraction = 5
    hdd_size      = 10
    hdd_type      = "network-hdd"
    image_id      = "fd84gg15m6kjdembasoq"
    nat           = true
    platform_id   = "standard-v1"
    zone          = "ru-central1-a"
    preemptible   = true
  }

  db = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    hdd_size      = 10
    hdd_type      = "network-hdd"
    image_id      = "fd84gg15m6kjdembasoq"
    nat           = true
    platform_id   = "standard-v1"
    zone          = "ru-central1-b"
    preemptible   = true
  }
}
