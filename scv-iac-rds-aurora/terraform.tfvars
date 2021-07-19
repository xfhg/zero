
region = "ap-southeast-1"

network_namespace = "scv"
network_stage = "development"
network_name = "zero"

rds_namespace = "scv"
rds_stage = "development"
rds_name = "aurora"

sg_namespace = "scv"
sg_stage = "development"
sg_name = "aurora-security"

## aurora

instance_type = "db.t3.small"
cluster_family = "aurora5.6"
cluster_size = 1
deletion_protection = false
autoscaling_enabled = false
engine = "aurora"
engine_mode = "provisioned"
db_name = "test_db"
admin_user = "admin"
admin_password = "admin_password"
enhanced_monitoring_role_enabled = true
rds_monitoring_interval = 30


