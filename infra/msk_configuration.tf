resource "random_id" "configuration" {
  prefix      = "${var.msk_cluster_name}-"
  byte_length = 8

  keepers = {
    server_properties = var.server_properties
  }
}

resource "aws_msk_configuration" "msk_config" {
  kafka_versions    = [var.kafka_version]
  name              = random_id.configuration.dec
  server_properties = random_id.configuration.keepers.server_properties

  lifecycle {
    create_before_destroy = true
  }
}