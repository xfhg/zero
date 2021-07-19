


region = "ap-southeast-1"

network_namespace = "scv"
network_stage = "development"
network_name = "zero"

rds_namespace = "scv"
rds_stage = "development"
rds_name = "rds"

sg_namespace = "scv"
sg_stage = "development"
sg_name = "rds-security"

deletion_protection = false
database_name = "test_db"
database_user = "admin"
database_password = "admin_password"
database_port = 3306
multi_az = true
storage_type = "standard"
storage_encrypted = false
allocated_storage = 5
engine = "mysql"
engine_version = "5.7.17"
major_engine_version = "5.7"
instance_class = "db.t2.small"
db_parameter_group = "mysql5.7"
publicly_accessible = false
apply_immediately = true