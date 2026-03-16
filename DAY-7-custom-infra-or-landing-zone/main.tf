resource "aws_vpc" "dev_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev"
    }
  
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.dev_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "public_dev_subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.dev_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "private_dev_subnet"
    }
  
}

resource "aws_internet_gateway" "dev" {
    vpc_id = aws_vpc.dev_vpc.id
    tags = {
      Name = "dev_IG"
    }
}

resource "aws_route_table" "dev" {
    vpc_id = aws_vpc.dev_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev.id
    }
  
}

resource "aws_route_table_association" "dev" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.dev.id

}


resource "aws_security_group" "dev" {
    name = "dev-sg"
    description = "allow all tarffic"
    vpc_id = aws_vpc.dev_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
}

resource "aws_instance" "dev" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [ aws_security_group.dev.id ]
    tags = {
      Name = "dev_instance"
    }
  
}