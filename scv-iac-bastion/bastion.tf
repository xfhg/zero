

module "autoscale_group" {
  source = "./modules/terraform-aws-ec2-autoscale-group"

  namespace  = var.bastion_namespace
  stage      = var.bastion_stage
  name       = var.bastion_name

  image_id                      = data.aws_ami.ubuntu.id
  instance_type                 = var.instance_type
  instance_market_options       = var.instance_market_options
  mixed_instances_policy        = var.mixed_instances_policy
  subnet_ids                    = data.aws_subnet_ids.public_subnet_ids.ids
  health_check_type             = var.health_check_type
  min_size                      = var.min_size
  max_size                      = var.max_size
  wait_for_capacity_timeout     = var.wait_for_capacity_timeout
  associate_public_ip_address   = true
  user_data_base64              = base64encode(local.userdata)
  metadata_http_tokens_required = true

  security_group_ids            = [module.bastion-sg.id]

  tags = {
    Tier              = "1"
  }

  # Auto-scaling policies and CloudWatch metric alarms
  autoscaling_policies_enabled           = true
  cpu_utilization_high_threshold_percent = var.cpu_utilization_high_threshold_percent
  cpu_utilization_low_threshold_percent  = var.cpu_utilization_low_threshold_percent

  block_device_mappings = [
    {
      device_name  = "/dev/sdb"
      no_device    = null
      virtual_name = null
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 10
        volume_type           = "gp2"
        iops                  = null
        kms_key_id            = null
        snapshot_id           = null
      }
    }
  ]


}

# https://www.terraform.io/docs/configuration/expressions.html#string-literals
locals {
  userdata = <<-USERDATA
    #!/bin/bash
    cat <<"__EOF__" > /home/ec2-user/.ssh/config
    Host *
        StrictHostKeyChecking no
    __EOF__
    chmod 600 /home/ec2-user/.ssh/config
    chown ec2-user:ec2-user /home/ec2-user/.ssh/config
  USERDATA
}


module "bastion-sg" {
  source = "./modules/terraform-aws-security-group"

  vpc_id = data.aws_vpc.baseline.id

namespace  = var.sg_namespace
  name       = var.sg_name
  stage      = var.sg_stage
  
  rules = [
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow Access from VPC"
    },
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "all"
      cidr_blocks = [data.aws_vpc.baseline.cidr_block]
      self        = null
      description = "Allow egress to VPC"
    }
  ]

 
}