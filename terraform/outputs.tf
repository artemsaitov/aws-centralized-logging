output "ec2_application_log_group" {
  description = "CloudWatch Log Group for EC2 application logs"
  value       = aws_cloudwatch_log_group.ec2_application.name
}

output "ec2_system_log_group" {
  description = "CloudWatch Log Group for EC2 system logs"
  value       = aws_cloudwatch_log_group.ec2_system.name
}

output "lambda_log_group" {
  description = "CloudWatch Log Group for Lambda logs"
  value       = aws_cloudwatch_log_group.lambda.name
}

output "cloudtrail_log_group" {
  description = "CloudWatch Log Group for CloudTrail events"
  value       = aws_cloudwatch_log_group.cloudtrail.name
}

output "vpc_flow_log_group" {
  description = "CloudWatch Log Group for VPC Flow Logs"
  value       = aws_cloudwatch_log_group.vpc_flow.name
}

output "log_archive_bucket" {
  description = "S3 bucket used for centralized log archival"
  value       = aws_s3_bucket.log_archive.id
}

output "cloudtrail_name" {
  description = "Name of the centralized CloudTrail trail"
  value       = aws_cloudtrail.main.name
}