import groovy.json.JsonSlurper

pipeline {
    agent any
  environment {
        JIRA_ISSUE_KEY = "${params.JIRA_ISSUE_KEY}"
        TRANSITION_ID = "${params.TRANSITION_ID}"
    }
    stages {
        stage('Update Status') {
            steps {
                script {
                    def commitMessage = sh(script: "git log --format=%B -n 1 HEAD", returnStdout: true).trim()

                    def index = commitMessage.indexOf(' ')

                    def issueKey = commitMessage.substring(0, index)

                    if (issueKey) {
                        // Define the new status
                        def newStatus = "Done"
                        
                        // Update status using REST API
                        def transitionId = getTransitionId(issueKey, newStatus)
                        println "Transition ID for ${newStatus}: ${transitionId}"

                        if (transitionId != null) {
                            def response = sh(script: "curl -u jira:jira -X POST -H 'Content-Type: application/json' -d '{\"transition\": {\"id\": \"${transitionId}\"}}' http://172.17.0.3:8080/rest/api/2/issue/${issueKey}/transitions", returnStdout: true)
                            println "Response: ${response}"
                            println "yehuda1 ${transitionId}"
                        } else {
                            println "Transition ID not found for ${newStatus}."
                            println "yehuda2 ${transitionId}"
                        }
                    } else {
                        println "Issue key not found in commit message."
                        //println "yehuda3 ${transitionId}"
                    }
                }
            }
        }
    }
}

def getTransitionId(issueKey, statusName) {
    def response = sh(script: "curl -u jira:jira -X GET -H 'Content-Type: application/json' http://172.17.0.3:8080/rest/api/2/issue/${issueKey}/transitions", returnStdout: true).trim()
    def jsonSlurper = new JsonSlurper()
    def transitions = jsonSlurper.parseText(response)

    println "All Transitions: ${transitions}"
    //println "yehuda4 ${transitionId}"

    for (transition in transitions.transitions) {
        println "Transition: ${transition}"
        //println "yehuda5 ${transitionId}"
        if (transition.to.name == statusName) {
            return transition.id
                    }
    }
        return null
}
