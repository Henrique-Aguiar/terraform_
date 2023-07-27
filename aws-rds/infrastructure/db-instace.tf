resource "aws_db_instance" "db_2" {
  identifier             = "database-1"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "12345678"
  parameter_group_name   = "default.mysql8.0"
  copy_tags_to_snapshot  = true
  skip_final_snapshot    = true
  storage_encrypted      = true
  storage_type           = "gp2"
  max_allocated_storage  = 990
  vpc_security_group_ids = ["sg-0f7f7d307ffeaf01a"]
}
