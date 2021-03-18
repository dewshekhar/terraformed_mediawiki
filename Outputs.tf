output "Conection_Strings" {
  description = "Conection_Strings"
  value = toset(split(",", "endpoint=${aws_lb.lb.dns_name}/mediawiki, Host=localhost, Username=wiki, Database=wikidatabase, Password=admin@passmedia123"))
} 
