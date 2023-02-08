# ################################################################################
# Create Blue Green Deployment for RDS
# ################################################################################


1. To create blue/green environmnet uncomment "Create - Blue Green Environment" and run terraform.

2. To perform switch over deployment you need:
    1. Comment create block "Create - Blue Green Environment".
    2. Uncomment describe block "Describe - get bgd-id".
    3. Uncomment switch block "Switch Over - Switch green(stage) with blue(production)".
    4. Run terraform.

3. To Delete blue/green environmnet you need:
    1. Comment describe block "Describe - get bgd-id".
    2. Comment switch block "Switch Over - Switch green(stage) with blue(production".
    3. Run terraform.
    4. Uncomment describe block "Describe - get bgd-id".
    5. Uncomment delete block "Delete Deployment":
        1. If you did a switch-over you need run with --no-delete-target parameter (Not deleting green)
        2. If you didn't a switch-over you need run with --delete-target parameter (Deleting green)
    6. Run terraform.