node{
  stage('Scm Checkout'){
    git credentialsId: 'git-creds', url: 'https://github.com/chrisolido/headspin.git'
  }
  stage('Scm Checkout'){
    sh 'docker build . -t testblueimage -f blue/Dockerfile'
    sh 'docker build . -t testblueimage -f green/Dockerfile'
  }
  stage('Test Blue Build container'){
    sh 'docker run -p 80:8080 -d testblueimage bogsolido/testblueimage'
  }
  stage('Test Green Build container'){
    sh 'docker run -p 80:8080 -d testgreenimage bogsolido/testgreenimage'
  }
  stage('Push Docker Image'){
    withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
      sh "docker login -u bogsolido -p ${dockerHubPwd}"
    }
      sh 'docker push bogsolido/testblueimage'
      sh 'docker push bogsolido/testgreenimage'
    }
  stage('Create the Blue Pod in EKS'){
    sshagent(['Jenkins-server']) {
      script{
        try{
          sh 'ssh ubuntu@3.1.60.7 kubectl apply -f headspin/blue/blue-controller.json'
        }
      }
    }
  }
}
