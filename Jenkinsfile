pipeline {
    agent any
    environment {
        JIRA_URL = 'http://172.17.0.3:8080'  // Your Jira URL
        ISSUE_KEY = 'story-jira-integ-jenkins'  // The key of the Jira issue to transition
        TRANSITION_ID = 'JIR-1'  // The ID of the transition
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
        stage('Jira') { 
            steps {
                sh 'echo create new jira issue'
                
            }
}
}
}
