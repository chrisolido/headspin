pipeline {
   agent any
   stage('Clone Repo'){
   node('master'){
      cleanWs()
      checkout([$class: 'GitSCM', branches: [[name: '*/$GIT_BRANCH']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'git@github.com:chrisolido/web-app.git']]])
    }
  }
