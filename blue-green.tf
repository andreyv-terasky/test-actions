################################################################################
# Create Blue Green Deployment for RDS
################################################################################ 

locals {
  region                = "eu-west-1"
  timeout               = 600
  blue-green-deployment-name = "my-blue-green-deployment"
  output                = "json"
  BlueGreenDeploymentIdentifier = "bgd-ihbyha9rqggbcqpa"
  db_old = ""
}



# data "external" "test"{
#   program = ["bash", templatefile("${path.module}/blue_green_copy.sh", {
#     f_blue_green_name           = "my-blue-green-deployment"
#     f_source_db                 = "arn:aws:rds:eu-west-1:289094324109:db:terraform-20230129133017643500000001"
#     f_target_db_parameter_group = "default.mysql5.7"
#     f_region                    = "eu-west-1"
#   })]
# }


# data "external" "blue_green" {
#   program = ["bash", "${path.module}/blue_green_copy.sh"]
#   query = {
#     BLUE_GREEN_NAME = "my-blue-green-deployment"
#     SOURCE_DB = "arn:aws:rds:eu-west-1:289094324109:db:terraform-20230129133017643500000001"
#     TARGET_DB_PARAMETER_GROUP = "default.mysql5.7"
#     REGION = "eu-west-1"
#     OUTPUT = "json"
#   }
# }

# data "external" "blue_green" {
#   program = [ "bash", "${path.module}/blue_green.sh"]
# }

# resource "aws_rds_cluster" "default" {
#   cluster_identifier        = "aurora-cluster-demo"
#   engine                    = "aurora-mysql"
#   engine_version            = "5.7.mysql_aurora.2.10.2"
#   availability_zones        = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
#   database_name             = "mydb"
#   master_username           = "admin"
#   master_password           = "Andrey90!"
#   allocated_storage         = 10
# }

# resource "aws_rds_cluster_instance" "example" {
#   cluster_identifier = aws_rds_cluster.default.id
#   instance_class     = "db.serverless"
#   engine             = aws_rds_cluster.default.engine
#   engine_version     = aws_rds_cluster.default.engine_version
#   count              = 1
#   identifier         = "aurora-cluster-demo-${count.index}"
# }


# resource "aws_db_instance" "default" {
#   allocated_storage       = 10
#   db_name                 = "mydb"
#   engine                  = "mysql"
#   engine_version          = "5.7"
#   instance_class          = "db.t3.micro"
#   username                = "admin"
#   password                = "Andrey90!"
#   parameter_group_name    = "default.mysql5.7"
#   skip_final_snapshot     = true
#   backup_retention_period = 1
#   backup_window           = "09:00-10:00"
#   blue_green_update {
#     enabled = true
#   }
# }


# Create Parameter Store

# resource "aws_ssm_parameter" "db_identify" {
# depends_on = [
#   null_resource.name
# ]
#   name        = "blue-green-resource-id"
#   description = "The parameter description"
#   type = "String"
#   tags = {
#     Owner = "Andrey Vasiliev"
#   }
# } 

# Create Blue Green Deployment

# resource "null_resource" "name" {
#   provisioner "local-exec" {
#     command = "aws rds create-blue-green-deployment --blue-green-deployment-name $f_blue_green_name --source $f_source_db --target-db-parameter-group-name $f_target_db_parameter_group --output $f_output --region $f_region"
#     environment = {
#       f_blue_green_name           = local.blue-green-deployment-name
#       f_source_db                 = aws_db_instance.default.arn
#       f_target_db_parameter_group = aws_db_instance.default.parameter_group_name
#       f_region                    = local.region
#       f_output                    = local.output
#     }
#   }
# }

# output "created_blue_green_deployment" {
#   value = null_resource.name.triggers
# }

# # Describe  blue green deployment

# resource "null_resource" "desccribe" {
#   provisioner "local-exec" {
#     command = "aws rds describe-blue-green-deployments --filters Name=blue-green-deployment-name,Values=$f_blue_green_name --region $f_region --output $f_output"
#     environment = {
#       f_blue_green_name           = local.blue-green-deployment-name
#       f_region                    = local.region
#       f_output                    = local.output
#      }
#   }
# }

# output "name" {
#   value = null_resource.desccribe.triggers
# }

# output "id" {
#   value = null_resource.desccribe.id
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

# resource "null_resource" "delete" {
#   provisioner "local-exec" {
#     # You must specify region in command
#     //command = "aws rds delete-blue-green-deployment --blue-green-deployment-identifier $f_BlueGreenDeploymentIdentifier --delete-target --region $f_region --output $f_output"
#     environment = {
#       f_BlueGreenDeploymentIdentifier = local.BlueGreenDeploymentIdentifier
#       f_region                        = local.region
#       f_output                        = local.output
#     }
#     command = "aws rds delete-blue-green-deployment --blue-green-deployment-identifier $f_BlueGreenDeploymentIdentifier --no-delete-target --region eu-west-1 --output json"
#   }
# }

# resource "aws_db_instance" "old_rds" {
#   instance_class          = "unknown"
# }
# resource "aws_db_instance" "old_db" {
#   instance_class = "db.t3.micro"
#   skip_final_snapshot = true
# }