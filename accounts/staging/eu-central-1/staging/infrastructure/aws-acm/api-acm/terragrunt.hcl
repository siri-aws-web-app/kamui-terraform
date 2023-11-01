# Terragrunt configuration

include "root" {
  path = find_in_parent_folders()
}

locals {
  # Expose the base source path
  base_source = "${dirname(find_in_parent_folders())}/../modules/aws-acm"
}

# Set the location of Terraform configurations
terraform {
  source = local.base_source
}

inputs = {
    acm_aws_region = "eu-central-1"
    role_arn = "arn:aws:iam::416023482452:role/staging-role"
    domain_name = "api.staging.siri-freyr.xyz"
    zone_id = "Z03404641A81DWQMZ8XYF"
}