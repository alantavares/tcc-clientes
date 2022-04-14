# resource "aws_security_group" "msk_sg" {
#   name        = "${var.msk_cluster_name}-sg"
#   description = "Default security group to allow inbound/outbound from the VPC"
#   vpc_id      = var.vpc_id

#   ingress {
#     description = "Bootstrap server Plaintext"
#     from_port = "9092"
#     to_port   = "9092"
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Bootstrap server TLS"
#     from_port = "9094"
#     to_port   = "9094"
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Apache ZooKeeper Plaintext"
#     from_port = "2181"
#     to_port   = "2181"
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Apache ZooKeeper TLS"
#     from_port = "2182"
#     to_port   = "2182"
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }  

#   ingress {
#     from_port = "11001"
#     to_port   = "11001"
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port = "11002"
#     to_port   = "11002"
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# }