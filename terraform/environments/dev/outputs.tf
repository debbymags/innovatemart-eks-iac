output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}


output "orders_db_endpoint" {
  value       = aws_db_instance.orders.endpoint
  description = "PostgreSQL endpoint for orders service"
}

output "catalog_db_endpoint" {
  value = aws_db_instance.catalog_mysql.endpoint
}

output "carts_table_name" {
  value = aws_dynamodb_table.carts.name
}