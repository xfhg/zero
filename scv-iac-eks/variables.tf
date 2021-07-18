
variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "eks_namespace" {
  type        = string
  description = "eks module namespace"
}

variable "eks_stage" {
  type        = string
  description = "eks module stage"
}

variable "eks_name" {
  type        = string
  description = "eks module name"
}



variable "network_namespace" {
  type        = string
  description = "network module namespace"
}

variable "network_stage" {
  type        = string
  description = "network module stage"
}

variable "network_name" {
  type        = string
  description = "network module name"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.19"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = []
  description = "A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. Possible values [`api`, `audit`, `authenticator`, `controllerManager`, `scheduler`]"
}

variable "cluster_log_retention_period" {
  type        = number
  default     = 0
  description = "Number of days to retain cluster logs. Requires `enabled_cluster_log_types` to be set. See https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html."
}

variable "map_additional_aws_accounts" {
  description = "Additional AWS account numbers to add to `config-map-aws-auth` ConfigMap"
  type        = list(string)
  default     = []
}

variable "map_additional_iam_roles" {
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "map_additional_iam_users" {
  description = "Additional IAM users to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "oidc_provider_enabled" {
  type        = bool
  default     = true
  description = "Create an IAM OIDC identity provider for the cluster, then you can create IAM roles to associate with a service account in the cluster, instead of using `kiam` or `kube2iam`. For more information, see https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html"
}

variable "local_exec_interpreter" {
  type        = list(string)
  default     = ["/bin/sh", "-c"]
  description = "shell to use for local_exec"
}

variable "disk_size" {
  type        = number
  description = "Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided"
}

variable "instance_types" {
  type        = list(string)
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]. Terraform will only perform drift detection if a configuration value is provided"
}

variable "kubernetes_labels" {
  type        = map(string)
  description = "Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed"
  default     = {}
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes"
}


variable "cluster_encryption_config_enabled" {
  type        = bool
  default     = true
  description = "Set to `true` to enable Cluster Encryption Configuration"
}

variable "cluster_encryption_config_kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key ID to use for cluster encryption config"
}

variable "cluster_encryption_config_kms_key_enable_key_rotation" {
  type        = bool
  default     = true
  description = "Cluster Encryption Config KMS Key Resource argument - enable kms key rotation"
}

variable "cluster_encryption_config_kms_key_deletion_window_in_days" {
  type        = number
  default     = 10
  description = "Cluster Encryption Config KMS Key Resource argument - key deletion windows in days post destruction"
}

variable "cluster_encryption_config_kms_key_policy" {
  type        = string
  default     = null
  description = "Cluster Encryption Config KMS Key Resource argument - key policy"
}

variable "cluster_encryption_config_resources" {
  type        = list(any)
  default     = ["secrets"]
  description = "Cluster Encryption Config Resources to encrypt, e.g. ['secrets']"
}










variable "image_id" {
  type        = string
  description = "The EC2 image ID to launch"
  default     = ""
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  description = "Shutdown behavior for the instances. Can be `stop` or `terminate`"
  default     = "terminate"
}

variable "instance_type" {
  type        = string
  description = "Instance type to launch"
}

variable "iam_instance_profile_name" {
  type        = string
  description = "The IAM instance profile name to associate with launched instances"
  default     = ""
}

variable "key_name" {
  type        = string
  description = "The SSH key name that should be used for the instance"
  default     = ""
}

variable "security_group_ids" {
  description = "A list of associated security group IDs"
  type        = list(string)
  default     = []
}

variable "launch_template_version" {
  type        = string
  description = "Launch template version. Can be version number, `$Latest` or `$Default`"
  default     = "$Latest"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with an instance in a VPC"
  default     = false
}

variable "user_data_base64" {
  type        = string
  description = "The Base64-encoded user data to provide when launching the instances"
  default     = ""
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable/disable detailed monitoring"
  default     = true
}

variable "ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"

  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
    })
  }))

  default = []
}

variable "instance_market_options" {
  description = "The market (purchasing) option for the instances"

  type = object({
    market_type = string
    spot_options = object({
      block_duration_minutes         = number
      instance_interruption_behavior = string
      max_price                      = number
      spot_instance_type             = string
      valid_until                    = string
    })
  })

  default = null
}

variable "instance_refresh" {
  description = "The instance refresh definition"
  type = object({
    strategy = string
    preferences = object({
      instance_warmup        = number
      min_healthy_percentage = number
    })
    triggers = list(string)
  })

  default = null
}

variable "mixed_instances_policy" {
  description = "policy to used mixed group of on demand/spot of differing types. Launch template is automatically generated. https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#mixed_instances_policy-1"

  type = object({
    instances_distribution = object({
      on_demand_allocation_strategy            = string
      on_demand_base_capacity                  = number
      on_demand_percentage_above_base_capacity = number
      spot_allocation_strategy                 = string
      spot_instance_pools                      = number
      spot_max_price                           = string
    })
    override = list(object({
      instance_type     = string
      weighted_capacity = number
    }))
  })
  default = null
}

variable "placement" {
  description = "The placement specifications of the instances"

  type = object({
    affinity          = string
    availability_zone = string
    group_name        = string
    host_id           = string
    tenancy           = string
  })

  default = null
}

variable "credit_specification" {
  description = "Customize the credit specification of the instances"

  type = object({
    cpu_credits = string
  })

  default = null
}

variable "elastic_gpu_specifications" {
  description = "Specifications of Elastic GPU to attach to the instances"

  type = object({
    type = string
  })

  default = null
}

variable "disable_api_termination" {
  type        = bool
  description = "If `true`, enables EC2 Instance Termination Protection"
  default     = false
}

variable "max_size" {
  type        = number
  description = "The maximum size of the autoscale group"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the autoscale group"
}

variable "default_cooldown" {
  type        = number
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "health_check_grace_period" {
  type        = number
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  type        = string
  description = "Controls how health checking is done. Valid values are `EC2` or `ELB`"
  default     = "EC2"
}

variable "force_delete" {
  type        = bool
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "load_balancers" {
  type        = list(string)
  description = "A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead"
  default     = []
}

variable "target_group_arns" {
  type        = list(string)
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `Default`"
  type        = list(string)
  default     = ["Default"]
}

variable "suspended_processes" {
  type        = list(string)
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "placement_group" {
  type        = string
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}

variable "metrics_granularity" {
  type        = string
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupMinSize`, `GroupMaxSize`, `GroupDesiredCapacity`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupTerminatingInstances`, `GroupTotalInstances`"
  type        = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "wait_for_capacity_timeout" {
  type        = string
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
  default     = "10m"
}

variable "min_elb_capacity" {
  type        = number
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = 0
}

variable "wait_for_elb_capacity" {
  type        = number
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior"
  default     = 0
}

variable "protect_from_scale_in" {
  type        = bool
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events"
  default     = false
}

variable "service_linked_role_arn" {
  type        = string
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  default     = ""
}

variable "autoscaling_policies_enabled" {
  type        = bool
  default     = true
  description = "Whether to create `aws_autoscaling_policy` and `aws_cloudwatch_metric_alarm` resources to control Auto Scaling"
}

variable "scale_up_cooldown_seconds" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_up_scaling_adjustment" {
  type        = number
  default     = 1
  description = "The number of instances by which to scale. `scale_up_adjustment_type` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_up_adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_up_policy_type" {
  type        = string
  default     = "SimpleScaling"
  description = "The scaling policy type. Currently only `SimpleScaling` is supported"
}

variable "scale_down_cooldown_seconds" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_down_scaling_adjustment" {
  type        = number
  default     = -1
  description = "The number of instances by which to scale. `scale_down_scaling_adjustment` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_down_adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_down_policy_type" {
  type        = string
  default     = "SimpleScaling"
  description = "The scaling policy type. Currently only `SimpleScaling` is supported"
}

variable "cpu_utilization_high_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_high_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = number
  default     = 90
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_high_statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_low_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = number
  default     = 10
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_low_statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "desired_capacity" {
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the group, if not set will use `min_size` as value"
  default     = null
}

variable "default_alarms_enabled" {
  type        = bool
  default     = true
  description = "Enable or disable cpu and memory Cloudwatch alarms"
}

variable "custom_alarms" {
  type = map(object({
    alarm_name                = string
    comparison_operator       = string
    evaluation_periods        = string
    metric_name               = string
    namespace                 = string
    period                    = string
    statistic                 = string
    threshold                 = string
    treat_missing_data        = string
    ok_actions                = list(string)
    insufficient_data_actions = list(string)
    dimensions_name           = string
    dimensions_target         = string
    alarm_description         = string
    alarm_actions             = list(string)
  }))
  default     = {}
  description = "Map of custom CloudWatch alarms configurations"
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Set false to disable the Instance Metadata Service."
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 2
  description = <<-EOT
    The desired HTTP PUT response hop limit (between 1 and 64) for Instance Metadata Service requests.
    The default is `2` to support containerized workloads.
    EOT
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = true
  description = "Set true to require IMDS session tokens, disabling Instance Metadata Service Version 1."
}

variable "tag_specifications_resource_types" {
  type        = set(string)
  default     = ["instance", "volume"]
  description = "List of tag specification resource types to tag. Valid values are instance, volume, elastic-gpu and spot-instances-request."
}

variable "max_instance_lifetime" {
  type        = number
  default     = null
  description = "The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds"
}

variable "warm_pool" {
  type = object({
    pool_state                  = string
    min_size                    = number
    max_group_prepared_capacity = number
  })
  description = "If this block is configured, add a Warm Pool to the specified Auto Scaling group. See [warm_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#warm_pool)."
  default     = null
}

## bastion


variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

# variable "user_data" {
#   type        = list(string)
#   default     = []
#   description = "User data content"
# }

# variable "ssh_key_path" {
#   type        = string
#   description = "Save location for ssh public keys generated by the module"
# }

# variable "generate_ssh_key" {
#   type        = bool
#   description = "Whether or not to generate an SSH key"
# }

# variable "security_groups" {
#   type        = list(string)
#   description = "List of Security Group IDs allowed to connect to the bastion host"
# }

# variable "root_block_device_encrypted" {
#   type        = bool
#   default     = false
#   description = "Whether to encrypt the root block device"
# }

# variable "root_block_device_volume_size" {
#   type        = number
#   default     = 8
#   description = "The volume size (in GiB) to provision for the root block device. It cannot be smaller than the AMI it refers to."
# }

# variable "metadata_http_endpoint_enabled" {
#   type        = bool
#   default     = true
#   description = "Whether the metadata service is available"
# }

# variable "metadata_http_put_response_hop_limit" {
#   type        = number
#   default     = 1
#   description = "The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests."
# }

# variable "metadata_http_tokens_required" {
#   type        = bool
#   default     = false
#   description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2."
# }

# variable "associate_public_ip_address" {
#   type        = bool
#   default     = true
#   description = "Whether to associate public IP to the instance."
# }

variable "oidc" {}
