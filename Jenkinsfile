pipeline { 
    agent { 
        docker { image 'docker:latest' }
    }
    environment {
        DOCKER_CONFIG = "$HOME/.docker"
    }
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker version'
            }
        }
        stage('Build Web Server Image') {
            steps {
                writeFile file: 'app.py', text: '''
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Browser!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
'''
                writeFile file: 'Dockerfile', text: '''
FROM python:3.9
WORKDIR /app
COPY app.py .
RUN pip install flask
CMD ["python", "app.py"]
'''

                // Build Docker image
                sh 'docker build -t my-flask-app .'
            }
        }
        stage('Run Web Server') {
            steps {
                sh 'docker run -d -p 5000:5000 --name flask-server my-flask-app'
            }
        }
        stage('Verify Server is Running') {
            steps {
                sh 'curl -s http://localhost:5000'
            }
        }
    }
}
