resource "aws_instance" "dev" {
    ami = var.dev_ami
    instance_type = var.dev_instance_type
}

resource "aws_instance" "test" {
    ami = var.test_ami
    instance_type = var.test_instance_type
}
