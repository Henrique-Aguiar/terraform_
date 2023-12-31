resource "aws_instance" "api" {
  ami             = "ami-053b0d53c279acc90"
  instance_type   = "t2.micro"
  key_name        = "teste-ec2"
  security_groups = [aws_security_group.server_ec2.name, aws_security_group.ssh.name]

  user_data = file("${path.module}/scripts.sh")

  tags = {
    Name = "web"
  }
}