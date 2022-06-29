variable "name" {}
variable "engine" {
  default = "aurora-postgresql"
}
variable "engine_version" {
  default = "13.4"
}
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
variable "cloudwatch_log_exports" {
  type    = list(string)
  default = ["postgres"]
}
variable "db_parameter_group_suffix" {
  # need these defaults to not change existing db parameter groups
  default = {
    name_suffix = "aurora-postgres13-cluster-parameter-group"
    family_suffix = "postgresql13"
  }

}
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

