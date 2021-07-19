
region = "ap-southeast-1"

bastion_namespace = "scv"
bastion_stage = "development"
bastion_name = "bastion"

sg_namespace = "scv"
sg_stage = "development"
sg_name = "bastion-security"

network_namespace = "scv"
network_stage = "development"
network_name = "zero"

instance_type = "t3a.small"
health_check_type = "EC2"
wait_for_capacity_timeout = "10m"
max_size = 1
min_size = 1
cpu_utilization_high_threshold_percent = 90
cpu_utilization_low_threshold_percent = 20
mixed_instances_policy = {
  instances_distribution = null
  override = [{
    instance_type     = "t3.small"
    weighted_capacity = null
    }, {
    instance_type     = "t3a.small"
    weighted_capacity = null
  }]
}