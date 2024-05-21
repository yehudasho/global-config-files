pipeline {
    agent any

    // Define parameters
    parameters {
        string(name: 'PROJECT_KEY', defaultValue: 'TEST', description: 'Jira project key where the issue will be created')
        string(name: 'ISSUE_TYPE', defaultValue: 'Task', description: 'Type of the Jira issue to be created')
        string(name: 'SUMMARY', defaultValue: 'New issue from Jenkins', description: 'Summary of the Jira issue')
        string(name: 'DESCRIPTION', defaultValue: 'This issue was created by Jenkins pipeline.', description: 'Description of the Jira issue')
        string(name: 'PRIORITY', defaultValue: 'Medium', description: 'Priority of the Jira issue')
    }

    // Set environment variables
    environment {
        JIRA_API_URL = '172.17.0.3:8080/rest/api/2'
        JIRA_CREDENTIALS = 'jira_cred'  // Use Jenkins credentials for Jira username and password
    }

    stages {
        stage('Create Jira Issue') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jira_cred', usernameVariable: 'JIRA_EMAIL', passwordVariable: 'jira')]) {
                script {
                    sh """
                        curl -u $JIRA_EMAIL:$jira -X POST --data @transition.json -H "Content-Type: application/json" $JIRA_URL/rest/api/3/issue/$ISSUE_KEY/transitions
                        """
                    echo "Creating a new Jira issue in project ${params.PROJECT_KEY}"

                    // Extract username and password from the credentials
                 def jiraCredentials = credentials('jira_cred')  // Use Jenkins credentials for Jira username and password
                 def jiraUsername = jiraCredentials.username

                    // Base64 encode the username and password for basic authentication
                    def authString = "jira:jira".bytes.encodeBase64().toString()

                    // Construct the JSON payload for creating the Jira issue
                    def payload = """
                    {
                        "fields": {
                            "project": {
                                "key": "${params.PROJECT_KEY}"
                            },
                            "issuetype": {
                                "name": "${params.ISSUE_TYPE}"
                            },
                            "summary": "${params.SUMMARY}",
                            "description": "${params.DESCRIPTION}",
                            "priority": {
                                "name": "${params.PRIORITY}"
                            }
                        }
                    }
                    """

                    // HTTP request to Jira API to create a new issue
                    def response = httpRequest(
                        url: "${env.JIRA_API_URL}/issue",
                        httpMode: 'POST',
                        contentType: 'APPLICATION_JSON',
                        requestBody: payload,
                        customHeaders: [
                            [name: 'Authorization', value: "Basic ${authString}"],
                            [name: 'Content-Type', value: 'application/json']
                        ]
                    )

                    def jsonResponse = readJSON text: response.content
                    echo "Created Jira issue: ${jsonResponse.key} - ${jsonResponse.fields.summary}"
                }
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
