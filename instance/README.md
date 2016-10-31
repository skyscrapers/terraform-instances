# instance terraform module
This module creates one or multiple EC2 instances.

## Generated resources
- EC2 instance/s
- IAM role

## Required variables

### ami
String: the AMI to use to create the instances

### instance_type
String: the EC2 instance type to use

### key_name
String: the SSH key to deploy to the instances

### sgs
List: the security groups to apply to the instances

### subnets
List: the subnets on where to launch the instances

### name
String: a common name to add to the EC2 instances and tags

### environment
String: How do you want to call your environment, this is helpful if you have more than 1 VPC.

### project
String: The current project

## Optional variables

### instance_count
Integer: the number of EC2 instances to launch
Default: 1

### termination_protection
Boolean: set the termination protection flag to the instances
Default: false

### ebs_optimized
Boolean: use EBS optimized volumes
Default: false

### public_ip
Boolean: attach a public IP to the instances
Default: false

### root_vl_type
String: the type of the root volume. Can be "standard", "gp2", or "io1"
Default: "gp2"

### root_vl_size
String: size of the root volume, in GB
Default: "30"

### root_vl_delete
Boolean: whether the volume should be destroyed on instance termination
Default: true

## Example

```
module "bastion_host" {
  source        = "github.com/skyscrapers/terraform-instances//instance"
  name          = "bastion"
  subnets       = "${module.vpc.cat2_public_subnets}"
  project       = "${var.project}"
  environment   = "${var.environment}"
  ami           = "ami-a7f5bcd4"
  instance_type = "t2.micro"
  key_name      = "default"
  public_ip     = true
  sgs           = ["${module.securitygroups.sg_all_id}", "${module.securitygroups.sg_bastion_id}"]
}
```
