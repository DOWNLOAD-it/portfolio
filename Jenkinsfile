pipeline {
    agent any

    environment {
        // Updated to match your exact repository name
        DOCKER_USER = "userjavascript"
        IMAGE_NAME  = "portfolio" 
        DOCKER_IMAGE = "${DOCKER_USER}/${IMAGE_NAME}:${env.BUILD_NUMBER}"
        
        // K8s Configuration
        K8S_DEPLOYMENT_NAME = "portfolio-deployment"
        K8S_CONTAINER_NAME  = "portfolio-container"
    }

    stages {
        stage('Checkout') {
            steps {
                // Pulls from 'DOWNLOAD-it/portfolio'
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo "Building Docker image with BuildKit: ${DOCKER_IMAGE}"
                    // Adding DOCKER_BUILDKIT=1 before the command
                    sh "DOCKER_BUILDKIT=1 docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // make sure the docker creds are matching in jenkins
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo \$PASS | docker login -u \$USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to K3s Cluster') {
            steps {
                script {
                    echo "Injecting ${DOCKER_IMAGE} into K8s manifest..."
                    // Injects the new image tag into the deployment.yaml
                    sh "sed -i 's|\${DOCKER_IMAGE}|${DOCKER_IMAGE}|g' k8s/deployment.yaml"
                    
                    echo "Applying manifests to K3s..."
                    sh "kubectl apply -f k8s/deployment.yaml"
                    
                    echo "Waiting for pods to be Ready..."
                    sh "kubectl rollout status deployment/${K8S_DEPLOYMENT_NAME}"
                }
            }
        }

        stage('Cleanup') {
            steps {
                echo "Cleaning up local Docker layers to prevent 98% disk usage..."
                sh "docker image prune -f"
            }
        }
    }

    post {
        success {
            echo "Successfully deployed! Access your portfolio on Port 30080 of your Worker IP."
        }
        failure {
            echo "Build failed. Check the 'Console Output' in Jenkins for the error log."
        }
    }
}