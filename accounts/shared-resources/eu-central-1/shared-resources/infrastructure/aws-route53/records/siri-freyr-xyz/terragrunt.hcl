# Terragrunt configuration

include "root" {
  path = find_in_parent_folders()
}

locals {
  # Expose the base source path
  base_source = "${dirname(find_in_parent_folders())}/../modules/aws-route53/records"
}

# Set the location of Terraform configurations
terraform {
  source = local.base_source
}

inputs = {
  zone_name = "siri-freyr.xyz"
  records = [
    {
      name = ""
      type = "A"
      alias = {
        name                   = "d2ns85ttpy0os7.cloudfront.net"
        zone_id                = "Z2FDTNDATAQYW2"
      }
    }
  ]
}