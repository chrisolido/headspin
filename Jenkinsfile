node{
  stage('Scm Checkout'){
    git credentialsId: 'git-creds', url: 'https://github.com/chrisolido/headspin.git'
  }
  stage('Scm Checkout'){
    sh 'docker build . -t blue -f blue/Dockerfile'
    sh 'docker build . -t green -f green/Dockerfile'
  }
  stage('Tag the build image'){
    sh 'docker tag blue aws_account_id.dkr.ecr.region.amazonaws.com/blue'
    sh 'docker tag green aws_account_id.dkr.ecr.region.amazonaws.com/green'
  }
  stage('Push Docker Image'){
    withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
      sh "aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com"
    }
      sh 'docker push 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com/web-app-ecr:testblueimage'
      sh 'docker push 016524045799.dkr.ecr.ap-southeast-1.amazonaws.com/web-app-ecr:testgreenimage'
    }
  stage('Create the Blue Pod in EKS'){
  }
}
