pipeline {
    agent any

    environment {
        DOCKER_USER = "userjavascript"
        IMAGE_NAME  = "portfolio" 
        DOCKER_IMAGE = "${DOCKER_USER}/${IMAGE_NAME}:${env.BUILD_NUMBER}"
        K8S_DEPLOYMENT_NAME = "portfolio-deployment"
        K8S_CONTAINER_NAME  = "portfolio-container"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Fix Dependencies') {
            steps {
                script {
                    echo "Fixing package-lock.json..."
                    sh """
                        # Remove problematic files
                        rm -f package-lock.json
                        rm -rf node_modules
                        
                        # Reinstall
                        npm install --legacy-peer-deps
                        
                        # Update lock file
                        npm install --package-lock-only --legacy-peer-deps
                    """
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo "Building Docker image with fixed dependencies..."
                    sh "DOCKER_BUILDKIT=1 docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo \$PASS | docker login -u \$USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to K3s Cluster') {
            steps {
                script {
                    echo "Deploying to Kubernetes..."
                    sh "kubectl apply -f k8s/deployment.yaml"
                    sh "kubectl rollout status deployment/${K8S_DEPLOYMENT_NAME}"
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh "docker image prune -f || true"
                sh "rm -rf node_modules || true"
            }
        }
    }

    post {
        success {
            echo "✅ Successfully deployed!"
        }
        failure {
            echo "❌ Build failed. Check the console output."
        }
    }
}