pipeline {
    agent any
    environment {
        JIRA_URL = 'http://172.17.0.3:8080'  // Your Jira URL
        ISSUE_KEY = 'jira-integ-jenkins'  // The key of the Jira issue to transition
        TRANSITION_ID = 'JIR-2'  // The ID of the transition
        PROJECT_KEY = "${params.PROJECT_KEY}"
         SUMMARY = "${params.SUMMARY}"
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


withCredentials([usernamePassword(credentialsId: 'jira_cred', usernameVariable: 'JIRA_EMAIL', passwordVariable: 'jira')]) {
                    script {
                        def payload = """
                        {
                          "transition": {
                            "id": "${TRANSITION_ID}"
                          }
                        }
                        """

                        // Write the payload to a temporary file
                        writeFile file: 'transition.json', text: payload

                        // Execute the curl command to transition the Jira issue
                        sh """
                        curl -u jira:jira -X POST --data @transition.json -H "Content-Type: application/json" http://172.17.0.3:8080/rest/api/3/issue/$ISSUE_KEY/transitions
                        """
                        
                        // Clean up the temporary file
                        sh 'rm transition.json'
                    }
                }

                sh 'echo yehuda1'
                when {
                expression {
                   return env.PROJECT_KEY?.trim() && env.SUMMARY?.trim()
                }
            }
            steps {
                script {
                    echo "Creating a new Jira issue in project ${env.PROJECT_KEY}"

                    // Extract username and password from the credentials
                    def jiraUsername = env.jira
                    def jiraPassword = env.jira

                    // Base64 encode the username and password for basic authentication
                    def authString = "jira:jira".bytes.encodeBase64().toString()

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
        success {
            echo "Jira issue ${ISSUE_KEY} transitioned successfully."
        }
        failure {
            echo "Failed to transition Jira issue ${ISSUE_KEY}."
        }
    }
}
