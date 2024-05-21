pipeline {
    agent any
    environment {
        JIRA_URL = 'http://172.17.0.3:8080'  // Your Jira URL
        //ISSUE_KEY = 'jira-integ-jenkins'  // The key of the Jira issue to transition
        ISSUE_KEY = 'JIR-2'  // The key of the Jira issue to transition
        PRIORITY_NAME = 'High'
    }
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
    }
}

