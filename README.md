# terraform-instances
Terraform modules to set up a few commonly used instances.

## bastion

### Available variables:
* [`project`]: String(required): The current project
* [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.
* [`subnets`]: List(required): The subnets where the bastion host must be placed in.
* [`ami`]: String(required): The id of the AMI created by Packer for the bastion host
* [`vpc_id`]: String(required): The VPC id to launch the instance in.
* [`sg_all_id`]: String(required): ID of the generic security group that will be extended to allow SSH access from the bastion host
* [`ssh_key_name`]: String(required): Name of the sshkey to deploy on the bastion instance
* [`name`]: String(optional):default bastion. Name of the instance
* [`instance_type`]: String(optional):default t2.micro. The instance type to launch for the bastion host.
* [`sgs`]: List(optional):default []. Additional security groups to add to the bastion host.
* [`policy`]: String(optional)default ec2:Describe*. Policy document to attach to the bastion host.
* [`termination_protection`]: Bool(optional)default false. If true, enables EC2 Instance Termination Protection
* [`ebs_optimized`]: Bool(optional)default false. If true, the launched EC2 instance will be EBS-optimized.
* [`public_ip`]: Bool(optional)default false. Associate a public ip address with an instance in a VPC.
* [`root_vl_type`]: String(optional)default gp2. The type of volume. Can be "standard", "gp2", or "io1".
* [`root_vl_size`]: String(optional)default 30. The size of the volume in gigabytes.
* [`root_vl_delete`]: Bool(optional)default true. Whether the volume should be destroyed on instance termination
* [`user_data`]: List(optional)default [""]. The user data to provide when launching the instance. If `instance_count` >1, each instance launched will use user_data with the corresponding `user_data[count.index]`
* [`ebs_block_devices`]: List(optional)default []. A list of objects defining `ebs_block_device`, as described in the terraform documentation: https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices
* [`ebs_enabled`]: Bool(optional)default True. Wether you want the instance to have an inline EBS definition.


### Output
 * [`bastion_sg_id`]: String: The ID of the security group
 * [`instance_id`]: String: The instance IDs.
 * [`instance_az`]: String: The availability zone of the instances.
 * [`instance_placement_group`]: String: The placement group of the instances
 * [`instance_key_name`]: String: The key name of the instances
 * [`instance_public_dns`]: String: The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC
 * [`instance_public_ip`]: String: The public IP address assigned to the bastion. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip, as this field will change after the EIP is attached.
 * [`instance_network_interface_id`]: String: The ID of the network interface that was created with the instance
 * [`instance_private_dns`]: String: The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC
 * [`instance_private_ip`]: String: The private IP address assigned to the instances
 * [`instance_vpc_security_group_id`]: String: The associated security groups in non-default VPC
 * [`instance_subnet_id`]: String: The VPC subnet ID.

### Example
```
module "bastion" {
  source = "github.com/skyscrapers/terraform-instances//bastion"
  vpc_id        = "${module.vpc.vpc_id}"
  project       = "${var.project}"
  environment   = "${var.environment}"
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
* [`subnets`]: List(required): The subnets where the bastion host must be placed in.
* [`ami`]: String(required): The id of the AMI created by Packer for the bastion host
* [`key_name`]: String(required): Name of the sshkey to deploy on the bastion instance
* [`instance_type`]: String(required): The instance type to launch for the bastion host.
* [`sgs`]: List(required): Additional security groups to add to the bastion host.
* [`instance_count`]: Int(optional)default 1. Amount of bastion hosts to create.
* [`termination_protection`]: Bool(optional)default false. If true, enables EC2 Instance Termination Protection
* [`ebs_optimized`]: Bool(optional)default false. If true, the launched EC2 instance will be EBS-optimized.
* [`public_ip`]: Bool(optional)default false. Associate a public ip address with an instance in a VPC.
* [`root_vl_type`]: String(optional)default gp2. The type of volume. Can be "standard", "gp2", or "io1".
* [`root_vl_size`]: String(optional)default 30. The size of the volume in gigabytes.
* [`root_vl_delete`]: Bool(optional)default true. Whether the volume should be destroyed on instance termination
* [`user_data`]: List(optional)default [""]. The user data to provide when launching the instance. If `instance_count` >1, each instance launched will use user_data with the corresponding `user_data[count.index]`
* [`ebs_block_devices`]: List(optional)default []. A list of objects defining `ebs_block_device`, as described in the terraform documentation: https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices
* [`ebs_enabled`]: Bool(optional)default True. Wether you want the instance to have an inline EBS definition.

### Output
 * [`role_id`]: String: The ID of the role
 * [`instance_ids`]: List: The instance IDs.
 * [`instance_azs`]: List: The availability zone of the instances.
 * [`instance_placement_groups`]: List: The placement group of the instances
 * [`instance_key_names`]: List: The key name of the instances
 * [`instance_public_dns`]: List: The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC
 * [`instance_public_ips`]: List: The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip, as this field will change after the EIP is attached.
 * [`instance_network_interface_ids`]: List: The ID of the network interface that was created with the instances
 * [`instance_private_dns`]: List: The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC
 * [`instance_private_ip`]: List: The private IP address assigned to the instances
 * [`instance_vpc_security_group_ids`]: List: The associated security groups in non-default VPC
 * [`instance_subnet_ids`]: List: The VPC subnet ID.

### Example
```
module "bastion" {
  source = "github.com/skyscrapers/terraform-instances//instance"
  project       = "${var.project}"
  environment   = "${var.environment}"
  name          = "web"
  sgs           = ["sg-xxx","sg-xyz"]
  subnets       = ["subnet-xxx", "subnet-xyz"]
  key_name      = "mykey"
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```
