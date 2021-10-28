# Create an OCI VCN with an Ubuntu instance
This repository creates an OCI Virtual Network (VCN) with the following resources:
- A VCN with 172.16.131.0/24 CIDR block
- 2 subnets - one public and one private
- An Internet gateway and a route table
- A virtual machine instance with 1 vCPU and 1GB of memory
- VM instance has shape of VM.Standard.E3.Flex and by default uses Ubuntu 18.04 image
- VM instance resides in the public subnet with Internet access, and an ephemeral public IP
- **VM instance uses a security list that has port 22, 80, and 443 open to the Internet**

It leverages the official Oracle OCI modules [terraform-oci-compute-instance](https://github.com/oracle-terraform-modules/terraform-oci-compute-instance) and [terraform-oci-vcn](https://github.com/oracle-terraform-modules/terraform-oci-vcn) to provision most of the resources. It also uses a module in the folder called subnets to create the subnets and the security lists

## How to use the scripts
1. Rename terraform.tfvars.example in the root folder to terraform.tfvars and set the variables per your requirements.
   - Due to multiple modules being used, some of the variables required overlap but they are named differently
2. In the terraform.tfvars file, set "vcn_cidrs" to a CIDR you would want to use for the VCN. By default it's set to 172.16.131.0/24
3. In the terraform.tfvars file, change newbits and netnum to configure the subnets' prefixes that you want to configure. Check out this [awesome blog](http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/) if you don't understand what they mean. By default the /24 is devided into two /25 subnets with 172.16.131.128/25 being the public subnet
4. In the root folder's main.tf, in module "instance_flex" - configure variable "subnet_ocids" to determine which subnet the VM's vNIC will be attached to. By default the vNIC is attached to the public subnet and gets an ephemeral public IP automatically.
5. In the terraform.tfvars file, change the compute instance parameters (shape, image, type and etc) to meet your requirements
6. In the folder /module/subnets, modify security-list.tf and configure egress_security_rules and ingress_security_rules accordingly to meet your needs. ** By default, port 22, 80 and 443 are reachable from Internet so please take notice!! **
7. Go through the official [Terraform OCI provider documentation](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_vcn) to enhance this script and make modifications as needed
