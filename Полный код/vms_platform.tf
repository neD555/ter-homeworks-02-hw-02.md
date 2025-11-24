# WEB VM
resource "yandex_compute_instance" "vm_web" {
  name        = local.vm_web_full_name
  platform_id = var.vms_resources["web"].platform_id
  zone        = var.vms_resources["web"].zone

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  scheduling_policy {
    preemptible = var.vms_resources["web"].preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.vms_resources["web"].image_id
      size     = var.vms_resources["web"].hdd_size
      type     = var.vms_resources["web"].hdd_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = var.vms_resources["web"].nat
  }

  metadata = var.metadata
}

# DB VM
resource "yandex_compute_instance" "vm_db" {
  name        = local.vm_db_full_name
  platform_id = var.vms_resources["db"].platform_id
  zone        = var.vms_resources["db"].zone

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  scheduling_policy {
    preemptible = var.vms_resources["db"].preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.vms_resources["db"].image_id
      size     = var.vms_resources["db"].hdd_size
      type     = var.vms_resources["db"].hdd_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_b.id
    nat       = var.vms_resources["db"].nat
  }

  metadata = var.metadata
}
