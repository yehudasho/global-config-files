pipeline {
    agent any
    stages {
        stage('Start') {
            steps {
                sh 'echo Starting the pipilineof jenkinsfile'
            }
        }
        stage('CheckNodeVer') { 
            steps {
                sh 'echo Checking the version of node'
                sh '/usr/local/bin/node -v'
            }
        }
        stage('Build') { 
            steps {
                sh 'echo Building the new app'
                sh 'node /usr/local/bin/app.js'
            }
        }
          stage('Finish') { 
            steps {
                sh 'echo Finishing the pipeline process '
            }
        }
    }
}
