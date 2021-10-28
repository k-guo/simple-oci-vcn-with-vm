# The output value as a list is used in module "instance_flex" in root's main.tf
# It determines which subnet the instance's VNIC will reside in

output "public_subnet_id" {
  description = "Subnet ID of public subnet"
  value       = tolist([oci_core_subnet.public.id])
}

output "private_subnet_id" {
  description = "Subnet ID of private subnet"
  value       = tolist([oci_core_subnet.private.id])
}