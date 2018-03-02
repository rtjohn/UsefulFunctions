#!/bin/bash
# Collect user input for tags
echo "What tag should we add to this instance?"
read varname
echo "Your EC2 will have a tag consisting of: key is DST and value is $varname."

sec_grp=$(aws ec2 describe-security-groups --filters "Name=description, Values='default VPC security group'" --output text --query SecurityGroups[*].GroupId)
inst_id=$(aws ec2 run-instances --image-id ami-6a52840a --count 1 --instance-type t2.micro \
--key-name MyKeyPair --security-group-ids $sec_grp \
--output text --query Instances[*].[InstanceId]) 
aws ec2 create-tags --resources $inst_id --tags 'Key="DST"',Value=$varname
