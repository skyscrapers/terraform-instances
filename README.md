# terraform-instances
Terraform modules to set up a few commonly used instances. Based on the instance types it will automatically set the ebs_optimized parameter based on a list in the instance module.

## bastion

### Available variables:
* [`project`]: String(required): The current project
* [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.
* [`subnets`]: List(string)(required): The subnets where the bastion host must be placed in.
* [`ami`]: String(required): The id of the AMI created by Packer for the bastion host
* [`vpc_id`]: String(required): The VPC id to launch the instance in.
* [`sg_all_id`]: String(required): ID of the generic security group that will be extended to allow SSH access from the bastion host
* [`ssh_key_name`]: String(required): Name of the sshkey to deploy on the bastion instance
* [`name`]: String(optional):default bastion. Name of the instance
* [`instance_type`]: String(optional):default t2.micro. The instance type to launch for the bastion host.
* [`sgs`]: List(string)(optional):default []. Additional security groups to add to the bastion host.
* [`policy`]: String(optional)default ec2:Describe*. Policy document to attach to the bastion host.
* [`termination_protection`]: Bool(optional)default false. If true, enables EC2 Instance Termination Protection.
* [`public_ip`]: Bool(optional)default false. Associate a public ip address with an instance in a VPC.
* [`root_vl_type`]: String(optional)default gp2. The type of volume. Can be "standard", "gp2", or "io1".
* [`root_vl_size`]: String(optional)default 30. The size of the volume in gigabytes.
* [`root_vl_delete`]: Bool(optional)default true. Whether the volume should be destroyed on instance termination
* [`user_data`]: List(string)(optional)default [""]. The user data to provide when launching the instance. If `instance_count` >1, each instance launched will use user_data with the corresponding `user_data[count.index]`
* [`ebs_block_devices`]: List(map(string))(optional)default []. A list of objects defining `ebs_block_device`, as described in the terraform documentation: https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices
* [`tags`]: Map(optional): Optional tags to add to the instance.

### Output
 * [`bastion_sg_id`]: String: The ID of the security group
 * [`instance_id`]: String: The instance IDs.
 * [`instance_az`]: String: The availability zone of the instances.
 * [`instance_key_name`]: String: The key name of the instances
 * [`instance_public_dns`]: String: The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC
 * [`instance_public_ip`]: String: The public IP address assigned to the bastion. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip, as this field will change after the EIP is attached.
 * [`instance_network_interface_id`]: String: The ID of the network interface that was created with the instance
 * [`instance_private_dns`]: String: The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC
 * [`instance_private_ip`]: String: The private IP address assigned to the instances
 * [`instance_vpc_security_group_id`]: String: The associated security groups in non-default VPC
 * [`instance_subnet_id`]: String: The VPC subnet ID.
 * [`iam_role_id`]: String: The IAM Role ID attached to the bastion host.

### Example
```
module "bastion" {
  source = "github.com/skyscrapers/terraform-instances//bastion"
  vpc_id        = module.vpc.vpc_id
  project       = var.project
  environment   = var.environment
  sg_all_id     = "sg-xxx"
  sgs           = ["sg-xxx","sg-xyz"]
  subnets       = ["subnet-xxx", "subnet-xyz"]
  ssh_key_name  = "mykey"
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

## instance

### Available variables:
* [`project`]: String(required): The current project
* [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.
* [`name`]: String(required): Name of the instance
* [`subnets`]: List(string)(required): The subnets where the bastion host must be placed in.
* [`ami`]: String(required): The id of the AMI created by Packer for the bastion host
* [`key_name`]: String(required): Name of the sshkey to deploy on the bastion instance
* [`instance_type`]: String(required): The instance type to launch for the bastion host.
* [`sgs`]: List(string)(required): Additional security groups to add to the bastion host.
* [`instance_count`]: Number(optional)default 1. Amount of bastion hosts to create.
* [`termination_protection`]: Bool(optional)default false. If true, enables EC2 Instance Termination Protection
* [`public_ip`]: Bool(optional)default false. Associate a public ip address with an instance in a VPC.
* [`root_vl_type`]: String(optional)default gp2. The type of volume. Can be "standard", "gp2", or "io1".
* [`root_vl_size`]: String(optional)default 30. The size of the volume in gigabytes.
* [`root_vl_delete`]: Bool(optional)default true. Whether the volume should be destroyed on instance termination
* [`user_data`]: List(string)(optional)default [""]. The user data to provide when launching the instance. If `instance_count` >1, each instance launched will use user_data with the corresponding `user_data[count.index]`
* [`ebs_block_devices`]: List(map(string))(optional)default []. A list of objects defining `ebs_block_device`, as described in the terraform documentation: https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices
* [`tags`]: Map(optional): Optional tags to add to the instance.

### Output
 * [`role_id`]: String: The ID of the role
 * [`role_name`]: String: The name of the role
 * [`instance_ids`]: List(string): The instance IDs.
 * [`instance_azs`]: List(string): The availability zone of the instances.
 * [`instance_key_names`]: List(string): The key name of the instances
 * [`instance_public_dns`]: List(string): The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC
 * [`instance_public_ips`]: List(string): The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip, as this field will change after the EIP is attached.
 * [`instance_network_interface_ids`]: List(string): The ID of the network interface that was created with the instances
 * [`instance_private_dns`]: List(string): The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC
 * [`instance_private_ip`]: List(string): The private IP address assigned to the instances
 * [`instance_vpc_security_group_ids`]: List(string): The associated security groups in non-default VPC
 * [`instance_subnet_ids`]: List(string): The VPC subnet ID.

### Example
```
module "bastion" {
  source = "github.com/skyscrapers/terraform-instances//instance"
  project       = var.project
  environment   = var.environment
  name          = "web"
  sgs           = ["sg-xxx","sg-xyz"]
  subnets       = ["subnet-xxx", "subnet-xyz"]
  key_name      = "mykey"
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

## is_ebs_optimised
This module compares the instance that gets passed as a variable to a list of all ebs_optimised instances. If it matches it returns true otherwise false.

### Available variables:
* [`instance_type`]: String(required): type of instance that you want to know if its ebs_optimised or not

### Output
* [`is_ebs_optimised`]: Bool: the response whether that instance is ebs_optimised or not.

### Example
```
module "is_ebs_optimised" {
  source        = "github.com/skyscrapers/terraform-instances//is_ebs_optimised?ref=2.3.0"
  instance_type = "c5.large"
}
```

## puppet-userdata

This module generates a script that bootstraps puppet on the server. It'll install puppet 4 and target `puppetmaster01.int.skyscrape.rs` by default.

### Available variables:
* [`customer`]: String(required): Customer name
* [`project`]: String(optional): Name of the project
* [`environment`]: String(required): Environment it runs in
* [`function`]: String(required):Function of the server (eg web, db, elasticsearch)
* [`amount_of_instances`]: String(optional): For how many instances do you need user data. Defaults to 1
* [`puppetmaster`]: String(optional): Hostname of puppetmaster. Defaults to `puppetmaster01.int.skyscrape.rs`
* [`domain`]: String(optional): Domain to set as hostname. Defaults to `skyscrape.rs`

### Output
 * [`user_datas`]: List(string): The generated user-data script for each instance.

### Example
```
module "tools_userdata" {
  source              = "github.com/skyscrapers/terraform-instances//puppet-userdata?ref=1.0.1"
  amount_of_instances = 1
  environment         = terraform.workspace
  customer            = var.customer
  function            = "tools"
}
```
