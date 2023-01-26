variable "name" {}
variable "engine_version" {
  default = "13.4"
}

variable "vpc_id" {}

variable "subnets" {
  type = list(string)
}

variable "allowed_security_groups" {
  type = list(string)
}

variable "master_username" {}
variable "database_name" {}

variable "tags" {
  type = map(string)
  default = {
    Owner = "Batcave"
  }
}

variable "route53_zone_id" {
  default = ""
}
variable "route53_zone_base_domain" {
  description = "If route53_zone_id is an empty string, this variable is used to lookup the r53 zone dynamicaly"
  default     = ""
}

variable "route53_record_name" {
}

variable "worker_security_group_id" {}
variable "cluster_security_group_id" {}
variable "cluster_primary_security_group_id" {}

variable "db_parameter_group_parameters" {
  type = list(map(string))

  default = [
    {
      name  = "log_destination"
      value = "csvlog"
      }, {
      name  = "log_connections"
      value = "1"
      }, {
      name  = "log_disconnections"
      value = "1"
      }, {
      name  = "log_statement"
      value = "mod"
      }, {
      name  = "rds.force_admin_logging_level"
      value = "info"
      }, {
      name  = "pgaudit.log"
      value = "ddl, role, write"
    }
  ]
}


variable "db_cluster_parameter_group_parameters" {
  type = list(map(string))

  default = [{
    name  = "rds.force_autovacuum_logging_level"
    value = "warning"
    }
  ]
}

variable "instance_class" {
  default     = "db.r5.xlarge"
  description = "Instance classes for instances created under the cluster"
}

variable "instance_count" {
  default     = 1
  description = "How many instances to create under the cluster"
}

variable "subnet_group_name" {
  type        = string
  default     = null
  description = "Subnet group name, overriding the default of cluster_name"
}
variable "create_db_subnet_group" {
  type    = bool
  default = true
}

variable "instance_identifier_pseudoprefix" {
  type        = string
  default     = ""
  description = "A string prefix for the database instance names where the instance number will be appended. This is not to be confused with the 'name_prefix' field.  In general, leave this empty unless you're importing existing resources"
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "maintenance_window" {
  type    = string
  default = "mon:05:00-mon:06:00"
}

variable "database_users" {
  description = "A list of maps with user_name and secrets_manager_name to trigger the creation of aws secretsmanager secrets"
  type = list(object({
    user_name            = string
    secrets_manager_name = string
  }))
  default = []
}

variable "create_random_password" {
  description = "Determines whether to create random password for RDS primary cluster"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "The days to retain backups for. Default 7"
}

variable "skip_final_snapshot" {
  type    = bool
  default = false
}
