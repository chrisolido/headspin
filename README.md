# HeadSpin

Login with ECR:

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin xxxxxxxxx.dkr.ecr.ap-southeast-1.amazonaws.com

aws ecr list-images --repository-name web --region ap-southeast-1

