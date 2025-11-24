variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "service_account_key_file" {
  type = string
}

variable "vms_ssh_public_root_key" {
  type = string
}

variable "env_prefix" {
  type    = string
  default = "netology"
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
    image_id      = string
    nat           = bool
    platform_id   = string
    zone          = string
    preemptible   = bool
  }))
}

# metadata — общая карта
variable "metadata" {
  type = map(string)
}
