node{
  stage('Scm Checkout'){
    git credentialsId: 'git-creds', url: 'https://github.com/chrisolido/headspin.git'
  }
  stage('Scm Checkout'){
    sh 'docker build . -t web-app-ecr:testblueimage -f blue/Dockerfile'
    sh 'docker build . -t web-app-ecr:testgreenimage -f green/Dockerfile'
  }
  stage('Test Blue Build container'){
    sh 'docker run -p 80:8080 -d web-app-ecr:testblueimage web-app-ecr/testblueimage'
  }
  stage('Test Green Build container'){
    sh 'docker run -p 80:8080 -d web-app-ecr:testgreenimage web-app-ecr/testgreenimage'
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
