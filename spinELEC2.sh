#!/bin/bash
# Collect user input for tags
echo "Instance type:"
read varname1

echo "Tag instance:"
read varname2

# Grab the security group Id I use for DL instances
sec_grp=$(aws ec2 describe-security-groups --filters "Name = description, Values = 'SG for deep learning AMI'" --output text --query SecurityGroups[*].GroupId)

# Using the Louis Aslett AMI, spin up the instances and grab the id
inst_id=$(aws ec2 run-instances --image-id ami-bca063c4 --count 1 --instance-type $varname1 \
--key-name RTJ_AWS_KP --security-group-ids $sec_grp \
--output text --query Instances[*].[InstanceId]) 

# Using the ID from above, create the tags for the instance
aws ec2 create-tags --resources $inst_id --tags 'Key="DS_DL"',Value=$varname2