pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '/usr/local/bin/node -v'
            }
        }
        stage('Test') { 
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
    }
}
