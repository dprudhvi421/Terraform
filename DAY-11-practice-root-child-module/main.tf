module "vpc" {
    source = "./module/vpc"
    cidr_block = "10.0.0.0/16"
    tags = "cust-prudhvi-vpc"
  
}

module "ec2" {
    source = "./module/ec2"
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.micro"
    tags = "cust-prudhvi-ec2"
  
}