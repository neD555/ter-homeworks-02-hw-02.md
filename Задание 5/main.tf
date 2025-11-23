terraform {
  required_version = "~> 1.12.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = var.service_account_key_file
}

resource "yandex_vpc_network" "network" {
  name = "tf-net"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "tf-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "tf-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.20.0.0/24"]
}

# Первая ВМ (web)

resource "yandex_compute_instance" "vm_web" {
  name        = local.vm_web_full_name
  platform_id = var.vm_web_platform_id
  zone        = var.vm_web_zone

  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_web_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = var.vm_web_nat
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_public_root_key}"
  }
}

# Вторая ВМ (db)

resource "yandex_compute_instance" "vm_db" {
  name        = local.vm_db_full_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone

  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_db_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_b.id
    nat       = var.vm_db_nat
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_public_root_key}"
  }
}
