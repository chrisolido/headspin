pipeline {
    agent any

    stages {
        stage('Build Image') {
            steps {
                sh './run_docker.sh'
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
