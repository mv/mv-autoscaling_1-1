#
# subnet_a = ""
# subnet_b = ""
# $ aws ec2 describe-subnets --output text | grep SUBNETS | awk '{print $13,$3,$16,$15}'
#   942632789850 sa-east-1a vpc-0138870bc9a3082e1 subnet-020abad37607f8451  routable-a
#   942632789850 sa-east-1b vpc-0138870bc9a3082e1 subnet-0dd9179257f479673  routable-b

#   942632789850 sa-east-1a vpc-0138870bc9a3082e1 subnet-0918f9a613498a55d  priv-a
#   942632789850 sa-east-1b vpc-0138870bc9a3082e1 subnet-0a9395c0807e346b6  priv-b

#   942632789850 sa-east-1a vpc-0138870bc9a3082e1 subnet-03fbb463d95d4f477  db-a
#   942632789850 sa-east-1b vpc-0138870bc9a3082e1 subnet-08798f1aee7078b9e  db-b


# tag: for self-discovery
vpc_name_tag = "vpc-dev"
# vpc_id  = "vpc-0138870bc9a3082e1"     # site/dev:

