variable "name" {
  description = "The name of the RDS cluster"
  type        = string
}
variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "14"
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = true
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "allowed_security_groups" {
  type = list(string)
}

variable "security_group_allowed_cidrs" {
  type    = list(string)
  default = []
}

variable "master_username" {
  type = string
}
variable "database_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    Owner = "Batcave"
  }
}

variable "route53_zone_id" {
  default = ""
  type    = string
}
variable "route53_zone_base_domain" {
  description = "If route53_zone_id is an empty string, this variable is used to lookup the r53 zone dynamicaly"
  default     = ""
  type        = string
}

variable "route53_record_name" {
  type = string
}

variable "worker_security_group_id" {
  type = string
}
variable "cluster_security_group_id" {
  type = string
}
variable "cluster_primary_security_group_id" {
  type = string
}

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
      value = "ddl,role,write"
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
  type        = string
}

variable "instance_count" {
  default     = 1
  description = "How many instances to create under the cluster"
  type        = number
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

variable "snapshot_identifier" {
  default     = null
  type        = string
  description = "If specified creates this database from a snapshot. Default is null.  Be warned that modifying this value on an already created database _WILL_ destroy/recreate the whole cluster."
}
