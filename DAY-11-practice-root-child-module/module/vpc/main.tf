resource "aws_vpc" "name" {
    cidr_block = var.cidr_block
    tags = {
      Name = var.tags
    }
  
}