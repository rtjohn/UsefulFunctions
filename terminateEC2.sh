#!/bin/bash 
# Collect user input for tags
echo "What tag did you give to your instance?"
read varname
echo "We will shut down an EC2 with a tag consisting of: key is DST and value is $varname."

echo -n "Do you wish to continue? (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    inst_id=$(aws ec2 describe-instances \
	    --filters "Name=image-id,Values=ami-6a52840a" "Name=tag:DST,Values=$varname" "Name=instance-state-name,Values=running" \
    	--output text --query Reservations[*].Instances[*].[InstanceId])
    aws ec2 terminate-instances \
    	--instance-ids $inst_id
else
    echo "This script will do nothing."
fi