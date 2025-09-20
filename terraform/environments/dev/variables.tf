# PostgreSQL for Orders service

variable "orders_db_username" {
    type        = string
    description = "Username for Orders PostgreSQL database"
    default = "ordersadmin"
}

variable "orders_db_password" {
    type        = string
    description = "Password for Orders PostgreSQL database"
    sensitive   = true
}


# MySQL for Catalog service
variable "catalog_db_username" {
    type = string 
    default = "catalogadmin"
}

variable "catalog_db_password" {
    type = string 
    sensitive   = true
}

# DynamoDB table name
variable "carts_table_name" {
    type = string 
    default = "carts"
}
