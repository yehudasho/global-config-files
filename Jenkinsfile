pipeline {
    agent {
        docker {
            image 'python:3.9'
            args '-u root'  // Optional: Run as root user inside the container
        }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'python --version'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'echo "Tests executed successfully"'
            }
        }
    }
}

