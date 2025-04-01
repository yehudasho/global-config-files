pipeline {
    agent {
        docker { image 'docker:latest' }
    }
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker version'
            }
        }
        stage('Run Python in Docker') {
            steps {
                sh 'docker run --rm python:3.9 python -c "print(\'Hello from Python in Docker!\')"'
            }
        }
    }
}
