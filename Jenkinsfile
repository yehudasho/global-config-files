pipeline {
    agent {
        docker { image 'python:3.9' }
    }
    stages {
        stage('Hello') {
            steps {
                script {
                    echo 'Hello, World!'
                }
            }
        }
    }
}
