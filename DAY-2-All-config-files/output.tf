output "PUBLIC_IP" {
    value = aws_instance.name.public_ip
}
output "ID" {
    value = aws_instance.name.id
}
