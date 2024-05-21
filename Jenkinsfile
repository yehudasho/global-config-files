pipeline {
    agent any
    environment {
        JIRA_URL = 'http://172.17.0.3:8080'  // Your Jira URL
        ISSUE_KEY = 'jira-integ-jenkins'  // The key of the Jira issue to transition
        TRANSITION_ID = 'JIR-2'  // The ID of the transition
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
                        curl -u $JIRA_EMAIL:$jira -X POST --data @transition.json -H "Content-Type: application/json" $JIRA_URL/rest/api/3/issue/$ISSUE_KEY/transitions
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
                        
                        // Clean up the temporary file
                        sh 'rm transition.json'
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
