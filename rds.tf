resource "aws_db_parameter_group" "blue_green_parameter_group" {
    name = "stage-parameter-group-rds"
    family = "mysql8.0"
    parameter {
      name = "read_only"
      value = "0"
    }
}

# resource "aws_db_instance" "rds_Instance" {
#   db_name                = "test_rds_db"
#   allocated_storage      = 10
#   max_allocated_storage  = 20
#   engine                 = "mysql"
#   engine_version         = "8.0"
#   instance_class         = "db.t3.micro"
#   username               = "admin"
#   password               = "!Andrey1989"
#   parameter_group_name   = "default.mysql8.0"
#   db_subnet_group_name   = aws_db_subnet_group.db_subnet_gp_name.name
#   skip_final_snapshot    = true
#   vpc_security_group_ids = [aws_security_group.rds_sg.id]
# }