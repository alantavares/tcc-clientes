resource "aws_db_instance" "clients_db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.27"
  instance_class       = "db.t3.micro"
  db_name              = "clients"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  apply_immediately    = true
  publicly_accessible  = true
}