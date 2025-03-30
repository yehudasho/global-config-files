pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Cloning the Git repository explicitly
                    git url: 'https://github.com/yehudasho/global-config-files.git'
                }
            }
        }
        stage('Build') {
            steps {
                echo "Building the project..."
            }
        }
    }
}
