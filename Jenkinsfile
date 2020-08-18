node{
  stage('Scm Checkout'){
    git credentialsId: 'git-creds', url: 'https://github.com/chrisolido/headspin.git'
  }
  stage('Scm Checkout'){
    sh 'docker build . -t blue -f blue/Dockerfile'
    sh 'docker build . -t green -f green/Dockerfile'
  }
  stage('Tag the build image'){
    sh 'docker tag blue 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com/web-app-ecr:blue'
    sh 'docker tag green 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com/web-app-ecr:green'
  }
  stage('Push Docker Image to ECR'){
    withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
      sh "aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com"
      sh 'docker push 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com/web-app-ecr:blue'
      sh 'docker push 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com/web-app-ecr:green'
      }
  }
  stage('Deploy the Blue Pod in EKS'){
      sshagent(['ssh-ubuntu']) {
        script{
          sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 192.168.1.166 kubectl apply -f /home/ubuntu/headspin/blue/blue-controller.json'
        }
     }
  }
  stage('Deploy the Green Pod in EKS'){
      sshagent(['ssh-ubuntu']) {
        script{
          sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 192.168.1.166 kubectl apply -f /home/ubuntu/headspin/green/green-controller.json'
       }
     }
  }
  stage('Deploy the Blue-Green Service (ELB) in EKS'){
       sshagent(['ssh-ubuntu']) {
         script{
           sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 192.168.1.166 kubectl apply -f /home/ubuntu/headspin/blue-green-service.json'
      }
    }
  }
  stage('Get the Public URL of the sevice'){
       sshagent(['ssh-ubuntu']) {
         script{
           sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 192.168.1.166 kubectl get svc bluegreenlb | awk '{print $4 $5}''
      }
    }
  }
}

