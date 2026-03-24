

aws autoscaling describe-scaling-activities \
  --auto-scaling-group-name asg-acme \
  --query "Activities[].{A: Progress, B: Description, C: Cause}" \
  --output text \
  | sed -e 's/\t/|/g'


#  {
#    "Activities": [
#      {
#        "ActivityId": "4c65e23d-a35a-4e7d-b6e4-2eaa8753dc12",
#        "AutoScalingGroupName": "my-asg",
#        "Description": "Terminating EC2 instance: i-04925c838b6438f14",
#        "Cause": "At 2021-04-01T21:48:35Z an instance was taken out of service in response to a user health-check.",
#        "StartTime": "2021-04-01T21:48:35.859Z",
#        "EndTime": "2021-04-01T21:49:18Z",
#        "StatusCode": "Successful",
#        "Progress": 100,
#        "Details": "{\"Subnet ID\":\"subnet-5ea0c127\",\"Availability Zone\":\"us-west-2a\"...}",
#        "AutoScalingGroupARN": "arn:aws:autoscaling:us-west-2:123456789012:autoScalingGroup:283179a2-f3ce-423d-93f6-66bb518232f7:autoScalingGroupName/my-asg"
#      },
#    ]
#  }