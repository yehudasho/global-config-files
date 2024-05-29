pipeline {
    agent any
    stages {
        stage('Start') {
            steps {
                sh 'echo my start jenkinsfile'
            }
        }
        stage('Check node version) { 
            steps {
                sh 'echo check ver of node'
                sh '/usr/local/bin/node -v'
            }
        }
        stage('Build app') { 
            steps {
                sh 'echo build the app jj '
            }
        }
    }
}
