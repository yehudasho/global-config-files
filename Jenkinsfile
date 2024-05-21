pipeline {
    agent any
    environment {
        JIRA_SITE = 'http://127.0.0.1:8090/browse/'
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
                jiraNewIssue site: "${JIRA_SITE}", projectKey: "${JIRA_PROJECT_KEY}", summary: "${ISSUE_SUMMARY}", description: "${ISSUE_DESCRIPTION}", type: 'Task'
            }
        }
        post {
        success {
            echo "Jira issue created successfully."
        }
        failure {
            echo "Failed to create Jira issue."
        }
    }
}

