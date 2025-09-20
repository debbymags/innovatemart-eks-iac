resource "kubernetes_secret" "orders_db" {
  metadata {
    name      = "orders-db-secret"
    namespace = "default"
  }

  data = {
    username = base64encode(var.orders_db_username)
    password = base64encode(var.orders_db_password)
    host     = base64encode(aws_db_instance.orders.endpoint)
    port     = base64encode("5432")
    dbname   = base64encode("ordersdb")
  }

  type = "Opaque"
}

resource "kubernetes_secret" "catalog_db" {
  metadata {
    name      = "catalog-db-secret"
    namespace = "default"
  }

  data = {
    username = base64encode(var.catalog_db_username)
    password = base64encode(var.catalog_db_password)
    host     = base64encode(aws_db_instance.catalog_mysql.endpoint)
    port     = base64encode("3306")
    dbname   = base64encode("catalog")
  }

  type = "Opaque"
}

resource "kubernetes_secret" "carts_table" {
  metadata {
    name      = "carts-secret"
    namespace = "default"
  }

  data = {
    tableName = base64encode(var.carts_table_name)
  }

  type = "Opaque"
}
