# resource "aws_msk_cluster" "msk_cluster" {
#   depends_on = [aws_msk_configuration.msk_config]

#   cluster_name           = var.msk_cluster_name
#   kafka_version          = var.kafka_version
#   number_of_broker_nodes = var.number_of_nodes
#   enhanced_monitoring    = "PER_BROKER"

#   broker_node_group_info {
#     client_subnets  = [
#       var.subnet1,
#       var.subnet2
#     ]
#     ebs_volume_size = var.ebs_volume_size
#     instance_type   = var.instance_type
#     security_groups = [aws_security_group.msk_sg.id]
#   }

#   configuration_info {
#     arn      = aws_msk_configuration.msk_config.arn
#     revision = aws_msk_configuration.msk_config.latest_revision
#   }

#   logging_info {
#     broker_logs {
#       cloudwatch_logs {
#         enabled   = true
#         log_group = aws_cloudwatch_log_group.msk_log.name
#       }
#     }
#   }

# }