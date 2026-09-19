resource "aws_cloudwatch_log_group" "ec2_application" {
  name              = "/centralized-logging/ec2/application"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "ec2_system" {
  name              = "/centralized-logging/ec2/system"
  retention_in_days = 7
}