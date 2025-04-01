pipeline {
    agent {
        docker { image 'docker:latest' }
    }
    
    environment {
        APP_NAME = 'flask-app'
    }
    
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker version'
            }
        }
        
        stage('Install Python Dependencies') {
            steps {
                // Create a requirements file
                writeFile file: 'requirements.txt', text: '''
flask
'''
                
                // Create a simple Flask app
                writeFile file: 'app.py', text: '''
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "Hello from Flask in Docker!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
'''
                
                // Run Docker container and install dependencies
                sh '''
                docker run --rm -v $PWD:/app python:3.9 bash -c "
                    pip install -r /app/requirements.txt && 
                    python /app/app.py &"
                '''
            }
        }
        
        stage('Build Docker Image') {
            steps {
                writeFile file: 'Dockerfile', text: '''
FROM python:3.9
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
'''
                
                sh 'docker build -t ${APP_NAME} .'
            }
        }
        
        stage('Run Flask App in Docker') {
            steps {
                sh 'docker run -d -p 5000:5000 --name ${APP_NAME} ${APP_NAME}'
            }
        }
        
        stage('Clean Up') {
            steps {
                sh 'docker container prune -f'
                sh 'docker image prune -f'
            }
        }
    }
}
