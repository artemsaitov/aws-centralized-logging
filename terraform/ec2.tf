data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "log_source" {
  ami                  = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.cloudwatch_agent.name

  user_data = templatefile("${path.module}/scripts/ec2-bootstrap.sh", {
    cloudwatch_agent_config = file("${path.module}/../configs/cloudwatch-agent.json")
  })

  tags = {
    Name = "centralized-logging-source"
  }
}