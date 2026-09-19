data "aws_vpc" "default" {
  default = true
}

resource "aws_cloudwatch_log_group" "vpc_flow" {
  name              = "/centralized-logging/vpc/flow"
  retention_in_days = 7
}

data "aws_iam_policy_document" "vpc_flow_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc_flow" {
  name               = "centralized-logging-vpc-flow"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_assume_role.json
}

data "aws_iam_policy_document" "vpc_flow_cloudwatch" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "vpc_flow_cloudwatch" {
  name   = "vpc-flow-cloudwatch-logging"
  role   = aws_iam_role.vpc_flow.id
  policy = data.aws_iam_policy_document.vpc_flow_cloudwatch.json
}
resource "aws_flow_log" "default_vpc" {
  vpc_id = data.aws_vpc.default.id

  traffic_type = "ALL"

  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow.arn

  iam_role_arn = aws_iam_role.vpc_flow.arn
}
