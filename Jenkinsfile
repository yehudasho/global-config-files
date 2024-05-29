pipeline {
    agent any
    stages {
        stage('Start') {
            steps {
                sh 'echo my first jenkinsfile'
            }
        }
        stage('CheckNodeVer') { 
            steps {
                sh '/usr/local/bin/node -v'
            }
        }
        stage('Build') { 
            steps {
                sh 'node /usr/local/bin/app.js'
            }
        }
    }
}
