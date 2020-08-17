pipeline {
  agent {
    kubernetes {
      //cloud 'kubernetes'
      yaml """
kind: Pod
metadata:
  name: img
spec:
  containers:
  - name: img
    image: jessfraz/img
    imagePullPolicy: Always
    command:
    - cat
    tty: true
    volumeMounts:
      - name: docker-config
        mountPath: /home/user/.docker
  volumes:
    - name: docker-config
      configMap:
        name: docker-config
"""
    }
  }
  stages {
    node{
    stage('Scm Checkout'){
      git credentialsId: 'git-creds', url: 'https://github.com/chrisolido/headspin.git'
    }
    stage('Build with Img') {
      environment {
        PATH = "/home/user/bin:$PATH"
      }
      steps {
        git 'https://github.com/chrisolido/headspin.git'
        container(name: 'img') {
            sh 'wget https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.3.1/linux-amd64/docker-credential-ecr-login'
            sh 'chmod +x docker-credential-ecr-login'
            sh 'mkdir ~/bin'
            sh 'mv docker-credential-ecr-login ~/bin/docker-credential-ecr-login'
            sh '''
            img build . -t 601307987632.dkr.ecr.ap-southeast-1.amazonaws.com/web:latest -t 601307987632.dkr.ecr.ap-southeast-1.amazonaws.com/web:vImg$BUILD_NUMBER
            '''
            sh ' img push 601307987632.dkr.ecr.ap-southeast-1.amazonaws.com/web:latest'
            sh ' img push 601307987632.dkr.ecr.ap-southeast-1.amazonaws.com/web:vImg$BUILD_NUMBER'
        }
      }
    }
  }
}

  
  
