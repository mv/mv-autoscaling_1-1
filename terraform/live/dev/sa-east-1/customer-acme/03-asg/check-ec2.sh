
 while true; do aws-ec2-list | grep acme | grep -v terminated; sleep 1; done

