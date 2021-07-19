
region = "ap-southeast-1"

eks_namespace = "scv"
eks_stage = "development"
eks_name = "zero"

network_namespace = "scv"
network_stage = "development"
network_name = "zero"

kubernetes_version = "1.20"
oidc_provider_enabled = true
enabled_cluster_log_types = ["audit"]
cluster_log_retention_period = 7
instance_types = ["t3.medium"]
desired_size = 2
max_size = 3
min_size = 2
disk_size = 30
kubernetes_labels = {}
cluster_encryption_config_enabled = true

instance_type = "t2.small"
health_check_type = "EC2"
wait_for_capacity_timeout = "10m"
cpu_utilization_high_threshold_percent = 80
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




# ssh_key_path = "./secrets"
# generate_ssh_key = true
# user_data = [
#   "yum install -y postgresql-client-common"
# ]
# security_groups = []
# root_block_device_encrypted = true
# metadata_http_tokens_required = true
# associate_public_ip_address = true
