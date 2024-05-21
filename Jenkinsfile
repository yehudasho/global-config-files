pipeline {
    agent any
    environment {
        JIRA_SITE = 'your-jira-site'
        JIRA_PROJECT_KEY = 'PROJ'
        ISSUE_SUMMARY = 'New issue created from Jenkins'
        ISSUE_DESCRIPTION = 'Description of the new issue'
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

