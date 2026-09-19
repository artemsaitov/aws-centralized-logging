#!/bin/bash
set -e

dnf install -y amazon-cloudwatch-agent rsyslog

systemctl enable rsyslog
systemctl start rsyslog

mkdir -p /var/log/myapp
touch /var/log/myapp/application.log

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'CONFIG'
${cloudwatch_agent_config}
CONFIG

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s

echo "$(date) INFO Application started successfully" >> /var/log/myapp/application.log