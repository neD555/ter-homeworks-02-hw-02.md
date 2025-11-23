locals {
  vm_web_full_name = "${var.env_prefix}-${var.vm_web_name}"
  vm_db_full_name  = "${var.env_prefix}-${var.vm_db_name}"
}
