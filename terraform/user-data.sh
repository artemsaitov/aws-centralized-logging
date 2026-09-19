#!/bin/bash
set -e

dnf install -y amazon-cloudwatch-agent

mkdir -p /var/log/myapp

touch /var/log/myapp/application.log

echo "$(date) INFO Application started" >> /var/log/myapp/application.log