# Packer image

`amzn-bastion.al2023`

Plain linux machine via SSM interface.

- `OS`: Amazon Linux
- `subnet`: private
- `ssh_interface`: `session_manager`


## SSM pre-requisites

### AWS Account level

Enable System Manager...

### AWS VPC level

Create VPC endpoints
- `ssm`
- `ssm.messages`
- `ec2.messages`

### EC2 level

Create an `instance profile` with any of the following managed policies:
- `AmazonSSMManagedInstanceCore`
- `AmazonSSMManagedInstanceCore`
