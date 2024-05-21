pipeline {
    agent any

    // Define parameters
    parameters {
        string(name: 'JIRA_JQL_QUERY', defaultValue: 'project = TEST AND status = "To Do"', description: 'JQL query to fetch Jira issues')
    }

    // Set environment variables
    environment {
        JIRA_JQL_QUERY = "${params.JIRA_JQL_QUERY}"
        JIRA_API_URL = '172.17.0.3:8080/rest/api/2/search'
        JIRA_CREDENTIALS = credentials('jira_cred')  // Use Jenkins credentials for Jira username and password
    }

    stages {
        stage('Fetch Jira Issues') {
            steps {
                script {
                    echo "Fetching Jira issues with JQL query: ${env.JIRA_JQL_QUERY}"

                    // Extract username and password from the credentials
                    def jiraUsername = env.JIRA_CREDENTIALS_USR
                    def jiraPassword = env.JIRA_CREDENTIALS_PSW

                    // Base64 encode the username and password for basic authentication
                    def authString = "${jira}:${jira}".bytes.encodeBase64().toString()

                    // Construct the URL with the JQL query
                    def apiUrl = "${env.JIRA_API_URL}?jql=${URLEncoder.encode(env.JIRA_JQL_QUERY, 'UTF-8')}"

                    // HTTP request to Jira API to fetch issues
                    def response = httpRequest(
                        url: apiUrl,
                        httpMode: 'GET',
                        customHeaders: [
                            [name: 'Authorization', value: "Basic ${authString}"],
                            [name: 'Content-Type', value: 'application/json']
                        ]
                    )

                    def jsonResponse = readJSON text: response.content
                    echo "Fetched Jira issues: ${jsonResponse}"

                    // Process and display the issues
                    def issues = jsonResponse.issues
                    issues.each { issue ->
                        echo "Issue Key: ${issue.key}, Summary: ${issue.fields.summary}, Status: ${issue.fields.status.name}"
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
