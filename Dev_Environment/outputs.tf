output "dev_server_ip" {
  value = aws_instance.dev_server.public_ip
}