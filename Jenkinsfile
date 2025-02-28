pipeline {
    agent any

   environment {
        // Get the branch name from GIT_BRANCH if not using Multibranch Pipeline
        BRANCH_NAME = "${env.GIT_BRANCH}".replaceFirst("origin/", "") // Ensure correct branch detection
    }
    
    stages {
        
        stage('Build Docker Image') {
            steps {
                sh './Build.sh'
            }
        }
      
stage('Push Docker Image to Docker Hub') {
    steps {
        script {
            withCredentials([usernamePassword(credentialsId: 'docker-hub-credential', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                sh """
                echo "Branch name is: ${env.BRANCH_NAME}"

                docker login -u \$DOCKER_USER -p \$DOCKER_PASSWORD
                if [ "\$BRANCH_NAME" = "dev" ]; then
                    docker tag govio/react-app:latest govio/dev:latest
                    docker push govio/dev:latest
                elif [ "\$BRANCH_NAME" = "master" ]; then
                    docker tag govio/react-app:latest govio/prod:latest
                    docker push govio/prod:latest
                fi
                """
            }
        }
    }
}



        stage('Deploy to Server') {
            steps {
                when { 
                expression { BRANCH_NAME == 'master' } 
            } 
                script {
                    sh """
                    chmod +x Deploy.sh
                    ./Deploy.sh
                    """
                }
            }
        }
    }
}
