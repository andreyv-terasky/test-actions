################################################################################
# Create Blue Green Deployment for RDS
################################################################################ 

locals {
  region                        = "eu-west-1"
  timeout                       = 600
  blue-green-deployment-name    = "my-blue-green-deployment"
  output                        = "json"
  //BlueGreenDeploymentIdentifier = jsondecode(data.local_file.bgd_id.content)["BlueGreenDeployment"]["BlueGreenDeploymentIdentifier"]
  

}


resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Andrey90!"
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  backup_retention_period = 1
  backup_window           = "09:00-10:00"
  blue_green_update {
    enabled = true
  }
}


# Create AWS SSM Parameter store for bgd

# resource "aws_ssm_parameter" "foo" {
#   depends_on = [
#     data.local_file.bgd_id
#   ]
#   name  = "blue-green-deployment"
#   type  = "String"
#   value = local.BlueGreenDeploymentIdentifier
# }

# Create Blue Green Deployment

# resource "null_resource" "create_bgd" {
#   provisioner "local-exec" {
#     command = "aws rds create-blue-green-deployment --blue-green-deployment-name $f_blue_green_name --source $f_source_db --target-db-parameter-group-name $f_target_db_parameter_group --output $f_output --region $f_region > bgd.json"
#     environment = {
#       f_blue_green_name           = local.blue-green-deployment-name
#       f_source_db                 = aws_db_instance.default.arn
#       f_target_db_parameter_group = aws_db_instance.default.parameter_group_name
#       f_region                    = local.region
#       f_output                    = local.output
#     }
#   }
# }

# data "local_file" "bgd_id" {
#   filename = "${path.module}/bgd.json"
#   depends_on = [
#     null_resource.create_bgd
#   ]
# }

# output "bgd" {
#   value = jsondecode(data.local_file.bgd_id.content)["BlueGreenDeployment"]["BlueGreenDeploymentIdentifier"]
# }

# output "blue-green" {
#   value = null_resource.name.triggers
# }

# Describe  blue green deployment

# resource "null_resource" "desccribe" {
#   provisioner "local-exec" {
#     command = "aws rds describe-blue-green-deployments --filters Name=blue-green-deployment-name,Values=$f_blue_green_name --region $f_region --output $f_output > example.json"
#     //command = "aws rds describe-blue-green-deployments --filters Name=blue-green-deployment-name,Values=$f_blue_green_name --region $f_region > output.json"
#     environment = {
#       f_blue_green_name           = local.blue-green-deployment-name
#       f_region                    = local.region
#       f_output                    = local.output
#      }
#   }
# }

# data "local_file" "blja_blja" {
#     filename = "${path.module}/example.json"
#   depends_on = [
#     null_resource.desccribe
#   ]
# }

# output "name" {
#   value = jsondecode(data.local_file.blja_blja.content)["BlueGreenDeployments"][0]["BlueGreenDeploymentIdentifier"]
# }





# data "aws_ssm_parameter" "bgd" {
#   name = aws_ssm_parameter.foo.name
# }

# output "bgd_id" {
#   value = jsondecode(data.aws_ssm_parameter.bgd.value)["BlueGreenDeployments"]
#   sensitive = true
# }

# Switch over 

# resource "null_resource" "switch" {
#   provisioner "local-exec" {
#     # You must specify region in command
#     command = "aws rds switchover-blue-green-deployment --blue-green-deployment-identifier $f_BlueGreenDeploymentIdentifier --switchover-timeout $f_timeout --region $f_region"
#     environment = {
#       f_BlueGreenDeploymentIdentifier = local.BlueGreenDeploymentIdentifier
#       f_region = local.region
#       f_timeout = local.timeout
#      }
#   }
# }

# Delete Deployment

# data "aws_ssm_parameter" "bgd_id" {
#   name = aws_ssm_parameter.foo.name
# }

resource "null_resource" "delete" {
  provisioner "local-exec" {
    # For Non completed switch over
    command = "aws rds delete-blue-green-deployment --blue-green-deployment-identifier $f_BlueGreenDeploymentIdentifier --delete-target --region $f_region --output $f_output"
    environment = {
      f_BlueGreenDeploymentIdentifier = "bgd-iry1wka8zsr4fbxz"
      f_region                        = local.region
      f_output                        = local.output
    }
    # Forcompleted switch over
    //command = "aws rds delete-blue-green-deployment --blue-green-deployment-identifier $f_BlueGreenDeploymentIdentifier --no-delete-target --region eu-west-1 --output json"
  }
}


# Import Green (Old DB instnce)

# resource "aws_db_instance" "old_db" {
#   instance_class = "db.t3.micro"
#   skip_final_snapshot = true
# }
