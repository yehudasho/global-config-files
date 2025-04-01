pipeline {
    agent {
        docker {
            image 'python:3.9'  // Use Python 3.9 as the agent
            args '--network=host --privileged' // Enable Docker-in-Docker
        }
    }

    environment {
        DOCKER_HOST = "tcp://docker-dind:2375" // Connect to DinD daemon
    }

    stages {
        stage('Check Environment') {
            steps {
                sh 'python --version'    // Verify Python 3.9
                sh 'docker version'      // Check Docker access
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-python-app .'  // Build the Docker image
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run --rm my-python-app'  // Run the Python container
            }
        }
    }
}
