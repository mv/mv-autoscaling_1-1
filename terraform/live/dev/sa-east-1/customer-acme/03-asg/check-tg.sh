
while true; do aws elbv2 describe-target-health --query 'TargetHealthDescriptions[].[TargetHealth.State,TargetHealth.Description][0]' --target-group-arn arn:aws:elasticloadbalancing:sa-east-1:942632789850:targetgroup/tg80-20260416221507437000000001/fa80b2e9dd97419a --output json|jq -c; sleep 1; done

