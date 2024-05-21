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
        stage('Jira Get Priority ID') { 
            steps {
                sh 'echo first Jira step'
                 withCredentials([usernamePassword(credentialsId: 'jira_cred', usernameVariable: 'JIRA_EMAIL', passwordVariable: 'jira')]) {
                    script {
                        def response = sh (
                            script: """
                                curl -u $JIRA_EMAIL:$JIRA_API_TOKEN -X GET -H "Content-Type: application/json" $JIRA_URL/rest/api/3/priority
                            """,
                            returnStdout: true
                        ).trim()

                        def priorities = new groovy.json.JsonSlurper().parseText(response)
                        def priorityId = priorities.find { it.name == PRIORITY_NAME }?.id

                        if (!priorityId) {
                            error "Priority '${PRIORITY_NAME}' not found"
                        }

                        env.PRIORITY_ID = priorityId
                    }
                }

        stage('Change Jira Issue Priority') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jira_cred', usernameVariable: 'JIRA_EMAIL', passwordVariable: 'jira')]) {
                    script {
                        def payload = """
                        {
                          "fields": {
                            "priority": {
                              "id": "${PRIORITY_ID}"
                            }
                          }
                        }
                        """

                        // Write the payload to a temporary file
                        writeFile file: 'update_priority.json', text: payload

                        // Execute the curl command to update the Jira issue's priority
                        sh """
                        curl -u $JIRA_EMAIL:$JIRA_API_TOKEN -X PUT --data @update_priority.json -H "Content-Type: application/json" $JIRA_URL/rest/api/3/issue/$ISSUE_KEY
                        """
                        
                        // Clean up the temporary file
                        sh 'rm update_priority.json'
                    }
                }
            }
        }

 post {
        success {
            echo "Jira issue ${ISSUE_KEY} priority updated to ${PRIORITY_NAME} successfully."
        }
        failure {
            echo "Failed to update priority of Jira issue ${ISSUE_KEY}."
        }
    }

                
            
        }
    }
}

