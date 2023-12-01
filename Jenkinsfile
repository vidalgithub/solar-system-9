pipeline {
  agent any

  environment {
    NAME = "solar-system"
    VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
    IMAGE_REPO = "vidaldocker"
    // ARGOCD_TOKEN = credentials('argocd-token')
    GITHUB_TOKEN = credentials('github-token')
    DOCKERHUB_CREDENTIALS=credentials('dockerhub')
  }
  
  stages {
    stage('Unit Tests') {
      steps {
        echo 'Implement unit tests if applicable.'
        echo 'This stage is a sample placeholder'
      }
    }

    stage('Build Image') {
      steps {
            sh "docker build -t ${NAME}:latest ."
            sh "docker tag ${NAME}:latest ${IMAGE_REPO}/${NAME}:${VERSION}"
        }
      }

    stage('Docker Login') {
      steps {
            sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
        }
      }

    stage('Push Image') {
      steps {
          sh 'docker push ${IMAGE_REPO}/${NAME}:${VERSION}'
      }
    }

    stage('Clone/Pull Repo') {
      steps {
        script {
          if (fileExists('gitops-argocd')) {

            echo 'Cloned repo already exists - Pulling latest changes'

            dir("gitops-argocd") {
              sh 'git pull'
            }

          } else {
            echo 'Repo does not exists - Cloning the repo'
            sh 'git clone -b feature https://github.com/vidalgithub/gitops-argocd.git'  
          }
        }
      }
    }
    
    stage('Update Manifest') {
      steps {
        dir("gitops-argocd/jenkins-demo") {
          sh 'sed -i "s#siddharth67.*#${IMAGE_REPO}/${NAME}:${VERSION}#g" deployment.yaml'
          sh 'cat deployment.yaml'
        }
      }
    }

    stage('Commit & Push') {
      steps {
        dir("gitops-argocd/jenkins-demo") {
          sh "git config --global user.email 'vidalngka@gmail.com'"
          sh "git config --global user.name 'vidalgithub'"
          sh 'git remote set-url origin https://$GITHUB_TOKEN@github.com/vidalgithub/gitops-argocd.git'
          sh 'git checkout feature'
          sh 'git add -A'
          sh 'git commit -am "Updated image version for Build - $VERSION"'
          sh 'git push origin feature'
        }
      }
    }
 /* Commenting out
    stage('Raise PR') {
      steps {
        sh "bash pr.sh"
      }
    } 
    */
  }
}
