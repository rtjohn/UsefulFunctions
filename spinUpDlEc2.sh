#!/bin/bash
# Collect user input for tags
echo "What tag should we add to this instance?"
read varname
echo "Your EC2 will have a tag consisting of: key is DST and value is $varname."

sec_grp=$(aws ec2 describe-security-groups --filters "Name=description, Values='SG for deep learning AMI'" --output text --query SecurityGroups[*].GroupId)
inst_id=$(aws ec2 run-instances --image-id ami-bca063c4 --count 1 --instance-type p2.xlarge \
--key-name RTJ_AWS_KP --security-group-ids $sec_grp \
--output text --query Instances[*].[InstanceId]) 
aws ec2 create-tags --resources $inst_id --tags 'Key="DST"',Value=$varname