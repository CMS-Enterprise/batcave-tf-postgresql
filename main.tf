locals {
  engine_version_short = split(".", var.engine_version)[0]
}
module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "6.1.4"

  name           = var.name
  engine         = "aurora-postgresql"
  engine_version = var.engine_version
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  instances = { for index in range(var.instance_count) : index + 1 =>
    merge(
      {},
      var.instance_identifier_pseudoprefix != "" ? { identifier = "${var.instance_identifier_pseudoprefix}${index + 1}" } : {}
  ) }
  publicly_accessible = false
  instance_class      = var.instance_class

  deletion_protection = var.deletion_protection

  endpoints = {
    static = {
      identifier = "static-custom-endpt-${var.name}"
      type       = "ANY"
    }
  }

  vpc_id                  = var.vpc_id
  subnets                 = var.subnets
  create_db_subnet_group  = var.create_db_subnet_group
  db_subnet_group_name    = var.subnet_group_name
  create_security_group   = true
  allowed_security_groups = var.allowed_security_groups
  security_group_egress_rules = {
    to_cidrs = {
      cidr_blocks = ["0.0.0.0/0"]
      description = "Egress to Internet"
    }
  }

  iam_database_authentication_enabled = true
  master_username                     = var.master_username
  create_random_password              = var.create_random_password
  database_name                       = var.database_name
  backup_retention_period             = var.backup_retention_period

  apply_immediately   = true
  skip_final_snapshot = var.skip_final_snapshot
  snapshot_identifier = var.snapshot_identifier

  db_parameter_group_name         = aws_db_parameter_group.db_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db_cluster_parameter_group.id
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = var.tags
  copy_tags_to_snapshot = true
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "${var.name}-aurora-db-postgres${local.engine_version_short}-parameter-group"
  family      = "aurora-postgresql${local.engine_version_short}"
  description = "${var.name}-aurora-db-postgres${local.engine_version_short}-parameter-group"
  dynamic "parameter" {
    for_each = var.db_parameter_group_parameters
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]
    }
  }
  tags = var.tags
}
resource "aws_rds_cluster_parameter_group" "db_cluster_parameter_group" {
  name        = "${var.name}-aurora-postgres${local.engine_version_short}-cluster-parameter-group"
  family      = "aurora-postgresql${local.engine_version_short}"
  description = "${var.name}-aurora-postgres${local.engine_version_short}-cluster-parameter-group"
  dynamic "parameter" {
    for_each = var.db_cluster_parameter_group_parameters
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]
    }
  }
  tags = var.tags
}

data "aws_route53_zone" "cms_zone" {
  count        = var.route53_zone_base_domain != "" ? 1 : 0
  name         = var.route53_zone_base_domain
  private_zone = true
}

resource "aws_route53_record" "www" {
  zone_id = coalesce(var.route53_zone_id, try(data.aws_route53_zone.cms_zone[0].zone_id,""))
  name    = var.route53_record_name
  type    = "CNAME"
  ttl     = "60"
  records = ["${module.aurora.cluster_endpoint}"]
}


# postgres egress rule for cluster_security_group
resource "aws_security_group_rule" "db-egress-cluster_security_group" {
  type                     = "egress"
  description              = "postgres traffic"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.aurora.security_group_id
  security_group_id        = var.cluster_security_group_id
}

# postgres egress rule for worker_security_group
resource "aws_security_group_rule" "db-egress-worker_security_group" {
  type                     = "egress"
  description              = "postgres traffic"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.aurora.security_group_id
  security_group_id        = var.worker_security_group_id
}

# postgres egress rule for cluster_primary_security_group
resource "aws_security_group_rule" "db-egress-cluster_primary_security_group" {
  type                     = "egress"
  description              = "postgres traffic"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.aurora.security_group_id
  security_group_id        = var.cluster_primary_security_group_id
}
