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
