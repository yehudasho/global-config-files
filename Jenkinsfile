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
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t web-server .'
            }
        }
        stage('Run Web Server') {
            steps {
                sh 'docker run -d -p 8000:8000 web-server'
            }
        }
    }
}
