pipeline {
    agent any
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
                sh 'echo Jira Integrated'

                def getTransitionId(issueKey, statusName) {
    def response = sh(script: "curl -u jira:jira -X GET -H 'Content-Type: application/json' http://172.17.0.3:8090/rest/api/2/issue/${issueKey}/transitions", returnStdout: true).trim()
    def jsonSlurper = new JsonSlurper()
    def transitions = jsonSlurper.parseText(response)

    println "All Transitions: ${transitions}"

    for (transition in transitions.transitions) {
        println "Transition: ${transition}"
        if (transition.to.name == statusName) {
            return transition.id
        }
    }

    return null
}


                
            }
        }
    }
}
