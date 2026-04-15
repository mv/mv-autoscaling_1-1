
aws ec2 describe-subnets --output text | grep SUBNETS | awk '{print $12,$3,$16,$15}'

# aws ec2 describe-subnets \
#   --query "Subnets[*].{ Name:Tags[?Key=='Name'].Value, vpc:VpcId, SubnetId:SubnetId, owner: OwnerId, cidr:CidrBlock, az:AvailabilityZone}" \
#   --output text
