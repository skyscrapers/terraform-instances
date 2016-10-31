# bastion module

This module sets up an EC2 bastion server.

## Generated resources
- EC2 instance/s
- IAM role

## Required variables

### vpc_id
String: the VPC where the resources will be created in.

### ami
String: the AMI to use to create the instances

### key_name
String: the SSH key to deploy to the instances

### subnets
List: the subnets on where to launch the bastion

### environment
String: How do you want to call your environment, this is helpful if you have more than 1 VPC.

### project
String: The current project

### sg_all_id
String: ID of the generic security group that will be extended to allow SSH access from the bastion host

## Optional variables

### instance_type
String: the EC2 instance type to use

### policy
String: the policy to attach to the instance. The default policy value is:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
```

### sgs
List: the generic security groups that need to be attached to the bastion host. 
Note that this module will add (and expose) an additional security group specific for specific bastion host rules.

## Outputs

### bastion_sg_id
String: the id of the bastion security group on which additional (application specific) rules can be added.

## Example

```
module "bastion_host" {
  source        = "github.com/skyscrapers/terraform-instances//bastion"
  project       = "${var.project}"
  environment   = "${var.environment}"
  ami           = "ami-a7f5bcd4"
  instance_type = "t2.micro"
  subnets       = "${module.vpc.cat2_public_subnets}"
  key_name      = "default"
  public_ip     = true
  sgs           = ["${module.securitygroups.sg_all_id}"]
}
```
