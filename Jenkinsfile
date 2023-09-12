pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your repository
                checkout scm
            }
        }
        
        stage('Build and Test') {
            steps {
                // Build and test your application
                sh './gradlew build'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Build Docker image and tag it with the build version
                script {
                    def buildVersion = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    sh "docker build -t my-app:${buildVersion} ."
                }
            }
        }
        
        stage('Push to ECR') {
            steps {
                // Push the Docker image to AWS ECR
                withCredentials([string(credentialsId: 'AKIARSMM5AJBQEWG3LVH', variable: 'AKIARSMM5AJBQEWG3LVH'),
                                 string(credentialsId: 'lYZ3VLiJBa9jwDpUBP3mVrhtw0s/2nV6dsvBzgLW', variable: 'lYZ3VLiJBa9jwDpUBP3mVrhtw0s/2nV6dsvBzgLW')]) {
                    script {
                        def buildVersion = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                        sh "docker tag my-app:${buildVersion} 108206555715.dkr.ecr.us-east-2.amazonaws.com/my-app:${buildVersion}"
                        sh "docker push 108206555715.dkr.ecr.us-east-2.amazonaws.com/my-app:${buildVersion}"
                    }
                }
            }
        }
        
        stage('Deploy to EC2') {
            steps {
                // Deploy the Docker image to EC2
                // You can use SSH or any deployment method of your choice
            }
        }
    }
    
    post {
            always {
                emailext (
                    subject: "${currentBuild.result}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                    body: "Check console output at $BUILD_URL to view the results.",
                    to: "vijayanandm333@gmail.com",
                    recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
        }
    }
}
