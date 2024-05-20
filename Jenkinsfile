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
                sh 'echo my first jenkinsfile'
            }
        }
        stage('Jira') { 
            steps {
                sh 'echo Jira Integrated'
            }
        }
    }
}
