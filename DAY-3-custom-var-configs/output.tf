output "dev_instance_type" {
    value =  aws_instance.dev.instance_type
}

output "test_instance_type" {
    value = aws_instance.test.instance_type
}