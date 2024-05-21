pipeline {
    agent any
    environment {
        JIRA_SITE = 'http://172.17.0.3:8080/'
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
                // jiraNewIssue site: "${JIRA_SITE}", projectKey: "${JIRA_PROJECT_KEY}", summary: "${ISSUE_SUMMARY}", description: "${ISSUE_DESCRIPTION}", type: 'Task'
                withCredentials([string(credentialsId: 'jira_cred', variable: 'JIRA_API_TOKEN'),
                                 string(credentialsId: 'jira-email', variable: 'JIRA_EMAIL')]) {
                    script {
                        def response = jiraNewIssue site: JIRA_SITE,
                                                   projectKey: JIRA_PROJECT_KEY,
                                                   summary: ISSUE_SUMMARY,
                                                   description: ISSUE_DESCRIPTION,
                                                   type: 'Task'

                        echo "Created Jira issue: ${response.data.key}"
                    }
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
        
}
}
