resource "aws_db_subnet_group" "catalog" {
  name       = "catalog-subnet-group"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_db_instance" "catalog_mysql" {
  identifier        = "catalog-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name              = "catalog"
  username          = var.catalog_db_username
  password          = var.catalog_db_password

  db_subnet_group_name  = aws_db_subnet_group.catalog.name
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  skip_final_snapshot = true
  publicly_accessible = false
}
