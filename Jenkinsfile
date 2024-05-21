pipeline {
    agent any

    // Define parameters
    parameters {
        string(name: 'PROJECT_KEY', defaultValue: '', description: 'Jira project key where the issue will be created')
        string(name: 'ISSUE_TYPE', defaultValue: 'Task', description: 'Type of the Jira issue to be created')
        string(name: 'SUMMARY', defaultValue: '', description: 'Summary of the Jira issue')
        string(name: 'DESCRIPTION', defaultValue: '', description: 'Description of the Jira issue')
        string(name: 'PRIORITY', defaultValue: 'Medium', description: 'Priority of the Jira issue')
    }

    // Set environment variables
    environment {
        PROJECT_KEY = "${params.PROJECT_KEY}"
        ISSUE_TYPE = "${params.ISSUE_TYPE}"
        SUMMARY = "${params.SUMMARY}"
        DESCRIPTION = "${params.DESCRIPTION}"
        PRIORITY = "${params.PRIORITY}"
        JIRA_API_URL = 'http://172.17.0.3:8080/rest/api/2'
        //JIRA_AUTH_TOKEN = credentials('jira_cred')  // Use Jenkins credentials for Jira authentication
        JIRA_AUTH_TOKEN = 'jira_cred'
    }

    stages {
        stage('Checkout') {
            steps {
                // Example: Clone your repository
                echo 'Checkout...'
            }
        }

        stage('Build') {
            steps {
                // Example: Build your project
                echo 'Building...'
                // Add your build commands here
            }
        }

        stage('Test') {
            steps {
                // Example: Run tests
                echo 'Testing...'
                // Add your test commands here
            }
        }

        stage('Deploy') {
            steps {
                // Example: Deploy your application
                echo 'Deploying...'
                // Add your deploy commands here
            }
        }

        stage('Create Jira Issue') {
            when {
                expression {
                    return env.PROJECT_KEY?.trim() && env.SUMMARY?.trim()
                   }
            }
            steps {
                script {
                    echo "Creating a new Jira issue in project ${env.PROJECT_KEY}"

                    // Construct the JSON payload for creating the Jira issue
                    def payload = """
                    {
                        "fields": {
                            "project": {
                                "key": "${env.PROJECT_KEY}"
                            },
                            "issuetype": {
                                "name": "${env.ISSUE_TYPE}"
                            },
                            "summary": "${env.SUMMARY}",
                            "description": "${env.DESCRIPTION}",
                            "priority": {
                                "name": "${env.PRIORITY}"
                            }
                        }
                    }
                    """

                    // Example: HTTP request to Jira API to create a new issue
                    def response = httpRequest(
                        url: "${env.JIRA_API_URL}/issue",
                        httpMode: 'POST',
                        contentType: 'APPLICATION_JSON',
                        requestBody: payload,
                        customHeaders: [
                            [name: 'Authorization', value: "Basic ${env.JIRA_AUTH_TOKEN}"],
                            [name: 'Content-Type', value: 'application/json']
                        ]
                    )

                    def jsonResponse = readJSON text: response.content
                    echo "Created Jira issue: ${jsonResponse.key} - ${jsonResponse.fields.summary}"
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline complete'
        }
    }
}
