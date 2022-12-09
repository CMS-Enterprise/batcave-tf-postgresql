variable "name" {}
variable "engine_version" {}
variable "publicly_accessible" {
  default = "false"
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
  default = {
    Owner = "Batcave"
  }
}

variable "route53_zone_id" {}
variable "route53_record_name" {}

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
      name  = "force_autovacuum_logging_level"
      value = "warning"
    }, {
      name  = "pgaudit.log"
      value = "ddl, role, write"
    }
  ]
}

