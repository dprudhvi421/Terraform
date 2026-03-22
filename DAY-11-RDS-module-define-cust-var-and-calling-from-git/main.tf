

module "rds" {
    
    source = "github.com/dprudhvi421/Terraform/DAY-11-RDS-module"
    vpc_cidr = "10.0.0.0/16"

subnets = {
  subnet1 = {
    cidr = "10.0.0.0/24"
    az   = "us-east-1a"
  }
  subnet2 = {
    cidr = "10.0.1.0/24"
    az   = "us-east-1b"
  }
}

db_identifier         = var.db_identifier        #here db_identifier is passing value to module variable and var.db_identifier is decalrined in variables.tf 
db_name               = var.db_name              #here db_name is passing value to module variable and var.db_name is decalrined in variables.tf 
db_instance_class     = "db.t3.micro"
db_allocated_storage  = var.db_allocated_storage #here db_allocated_storage is passing value to module variable and db_allocated_storage is decalrined in variables.tf
db_username           = var.db_username          #note here db_username is passing value to module variable and var.db_username is decalrined in variables.tf file and value is assigned in terraform.tfvars file


#backup_window      = "02:00-03:00"
#maintenance_window = "sun:04:00-sun:05:00"

  
}