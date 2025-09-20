resource "aws_db_subnet_group" "orders" {
  name       = "orders-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "orders-db-subnet-group"
  }
}

resource "aws_db_instance" "orders" {
  identifier              = "orders-db"
  engine                  = "postgres"
  engine_version          = "15.8"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  db_name                    = "ordersdb"
  username                = var.orders_db_username
  password                = var.orders_db_password
  db_subnet_group_name    = aws_db_subnet_group.orders.name
  vpc_security_group_ids  = [module.vpc.default_security_group_id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false

  tags = {
    Project = "InnovateMart"
    Env     = "dev"
  }
}
