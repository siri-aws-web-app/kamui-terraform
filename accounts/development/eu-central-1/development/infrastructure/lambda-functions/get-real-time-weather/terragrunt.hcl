# Terragrunt configuration

include "root" {
  path = find_in_parent_folders()
}

locals {
  # Expose the base source path
  base_source = "${dirname(find_in_parent_folders())}/../modules/aws-lambda"

  # Read the lambda_vars.hcl file
  lambda_vars = read_terragrunt_config(find_in_parent_folders("lambda_vars.hcl"))

  # Extract vars from the lambda_vars.hcl file
  weather_api_key_secret_arn = local.lambda_vars.locals.weather_api_key_secret_arn
}

# Set the location of Terraform configurations
terraform {
  source = local.base_source
}

inputs = {
    function_name = "getRealTimeWeather"
    function_description = "Get real time weather data from WeatherApi"
    source_path = "${dirname(find_in_parent_folders())}/../aws-lambda/nodejs/dist/handlers/get-real-time-weather"
    s3_bucket = "siri-aws-lambda-bucket"
    runtime = "nodejs18.x"
    handler = "index.lambdaHandler"
    policies = [
      "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
    ]
    number_of_policies = 1

    weather_api_key_secret_arn = local.weather_api_key_secret_arn
}