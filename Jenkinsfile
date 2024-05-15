pipeline {
    agent {label 'slave'}
    stages {
        stage('Get Sources') {
            steps {
                git 'https://gitlab.com/sela-devops/courses/jenkins-cicd/demo-app.git'
            }
        }
      stage('Restore Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') { 
            steps {
                sh 'npm run test' 
            }
        }
        stage('Package') { 
            steps {
                sh 'npm run build' 
            }
        }
        stage('Archive Artifacts') { 
            steps {
                archiveArtifacts '*.zip'
            }
        }  
    }
}