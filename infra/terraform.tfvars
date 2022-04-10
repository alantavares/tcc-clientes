project_name                       = "clientes"
aws_region                         = "us-east-1"
cluster_name                       = "clientes"
app_repository_name                = "clientes-php"
webserver_repository_name          = "clientes-nginx"
bucket_name                        = "clientes"
service_migration_name             = "clientes-migration"
alb_port                           = "80"
container_port                     = "9000"
container_name                     = "php"
webserver_container_port           = "80"
webserver_container_name           = "nginx"
vpc_id                             = "vpc-385f6c42"
subnet1                            = "subnet-1a77953b"
subnet2                            = "subnet-604ff82d"
subnet_alb_1                       = "subnet-1a77953b"
subnet_alb_2                       = "subnet-604ff82d"
migration_deploy_cmd               = "console doctrine:migrations:migrate -n"

# consumer vars
worker_consumer_name               = "tcc_clients_worker_consumer"
worker_consumer_container_port     = "9000"
worker_consumer_container_name     = "php"
worker_consumer_deploy_cmd         = "composer consumer"

# msk vars
msk_cluster_name                   = "clientes-msk"
number_of_nodes                    = 2
ebs_volume_size                    = 10
instance_type                      = "kafka.t3.small"
kafka_version                      = "2.8.1"
server_properties                   = <<PROPERTIES
auto.create.topics.enable = true
default.replication.factor = 2
PROPERTIES
