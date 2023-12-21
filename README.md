# batcave-tf-postgresql

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | terraform-aws-modules/rds-aurora/aws | 6.1.4 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.db_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.db_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_route53_record.www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group_rule.db-egress-cluster_primary_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db-egress-cluster_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db-egress-worker_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_route53_zone.cms_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | n/a | `list(string)` | n/a | yes |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | n/a | `bool` | `true` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. Default 7 | `number` | `7` | no |
| <a name="input_cluster_primary_security_group_id"></a> [cluster\_primary\_security\_group\_id](#input\_cluster\_primary\_security\_group\_id) | n/a | `string` | n/a | yes |
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | n/a | `string` | n/a | yes |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | n/a | `bool` | `true` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Determines whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | n/a | `string` | n/a | yes |
| <a name="input_db_cluster_parameter_group_parameters"></a> [db\_cluster\_parameter\_group\_parameters](#input\_db\_cluster\_parameter\_group\_parameters) | n/a | `list(map(string))` | <pre>[<br>  {<br>    "name": "rds.force_autovacuum_logging_level",<br>    "value": "warning"<br>  }<br>]</pre> | no |
| <a name="input_db_parameter_group_parameters"></a> [db\_parameter\_group\_parameters](#input\_db\_parameter\_group\_parameters) | n/a | `list(map(string))` | <pre>[<br>  {<br>    "name": "log_destination",<br>    "value": "csvlog"<br>  },<br>  {<br>    "name": "log_connections",<br>    "value": "1"<br>  },<br>  {<br>    "name": "log_disconnections",<br>    "value": "1"<br>  },<br>  {<br>    "name": "log_statement",<br>    "value": "mod"<br>  },<br>  {<br>    "name": "rds.force_admin_logging_level",<br>    "value": "info"<br>  },<br>  {<br>    "name": "pgaudit.log",<br>    "value": "ddl,role,write"<br>  }<br>]</pre> | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | `"14"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance classes for instances created under the cluster | `string` | `"db.r5.xlarge"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | How many instances to create under the cluster | `number` | `1` | no |
| <a name="input_instance_identifier_pseudoprefix"></a> [instance\_identifier\_pseudoprefix](#input\_instance\_identifier\_pseudoprefix) | A string prefix for the database instance names where the instance number will be appended. This is not to be confused with the 'name\_prefix' field.  In general, leave this empty unless you're importing existing resources | `string` | `""` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the RDS cluster | `string` | n/a | yes |
| <a name="input_route53_record_name"></a> [route53\_record\_name](#input\_route53\_record\_name) | n/a | `string` | n/a | yes |
| <a name="input_route53_zone_base_domain"></a> [route53\_zone\_base\_domain](#input\_route53\_zone\_base\_domain) | If route53\_zone\_id is an empty string, this variable is used to lookup the r53 zone dynamicaly | `string` | `""` | no |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | n/a | `string` | `""` | no |
| <a name="input_security_group_allowed_cidrs"></a> [security\_group\_allowed\_cidrs](#input\_security\_group\_allowed\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | If specified creates this database from a snapshot. Default is null.  Be warned that modifying this value on an already created database _WILL_ destroy/recreate the whole cluster. | `string` | `null` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Subnet group name, overriding the default of cluster\_name | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "Owner": "Batcave"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_worker_security_group_id"></a> [worker\_security\_group\_id](#input\_worker\_security\_group\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_cluster_endpoints"></a> [additional\_cluster\_endpoints](#output\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_cluster_database_name"></a> [cluster\_database\_name](#output\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_cluster_engine_version_actual"></a> [cluster\_engine\_version\_actual](#output\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_cluster_hosted_zone_id"></a> [cluster\_hosted\_zone\_id](#output\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_cluster_instances"></a> [cluster\_instances](#output\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_cluster_master_password"></a> [cluster\_master\_password](#output\_cluster\_master\_password) | The database master password |
| <a name="output_cluster_master_username"></a> [cluster\_master\_username](#output\_cluster\_master\_username) | The database master username |
| <a name="output_cluster_members"></a> [cluster\_members](#output\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_cluster_port"></a> [cluster\_port](#output\_cluster\_port) | The database port |
| <a name="output_cluster_reader_endpoint"></a> [cluster\_reader\_endpoint](#output\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_cluster_resource_id"></a> [cluster\_resource\_id](#output\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_cluster_role_associations"></a> [cluster\_role\_associations](#output\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_db_subnet_group_name"></a> [db\_subnet\_group\_name](#output\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_enhanced_monitoring_iam_role_arn"></a> [enhanced\_monitoring\_iam\_role\_arn](#output\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_enhanced_monitoring_iam_role_name"></a> [enhanced\_monitoring\_iam\_role\_name](#output\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_enhanced_monitoring_iam_role_unique_id"></a> [enhanced\_monitoring\_iam\_role\_unique\_id](#output\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
