output "vm_public_ip" {
  value = module.vm.public_ip
}

output "ssh_connection" {
  value = "ssh -i .keys/temp_rsa ${var.vm_admin_username}@${module.vm.public_ip}"
}
