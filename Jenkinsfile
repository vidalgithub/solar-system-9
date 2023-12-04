pipeline {
  agent {
        label 'gcp'
    }

  environment {
    NAME = "solar-system"
    VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
    IMAGE_REPO = "vidaldocker"
    // ARGOCD_TOKEN = credentials('argocd-token')
    GITHUB_TOKEN=credentials('github-token')
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
          sh '''
          sed -i "s#${IMAGE_REPO}.*#${IMAGE_REPO}/${NAME}:${VERSION}#g" deployment.yaml
          cat deployment.yaml
          '''
        }
      }
    }

    stage('Commit & Push') {
      steps {
        dir("gitops-argocd/jenkins-demo") {
          sh '''
          git config --global user.email 'vidalngka@gmail.com'
          git config --global user.name 'vidalgithub'
          git remote set-url origin https://$GITHUB_TOKEN@github.com/vidalgithub/gitops-argocd.git
          git checkout feature
          git add -A
          git commit -am "Updated image version for Build - $VERSION"
          git rev-parse --short=10 HEAD 
          git push origin feature
          '''
        }
      }
    }
        //tr -d "\r" <pr.sh >a.tmp
        //mv a.tmp pr.sh
        //echo "$ORIGINAL_TOKEN" | gh auth login --with-token -
        //gh auth login --with-token < mytoken.txt
    //git clone -b feature https://github.com/vidalgithub/solar-system-9.git
    stage('Raise PR') {
      steps {
        sh '''
        cd ../solar-system-9
        bash pr.sh
        '''
        }
      }
    } 

  }

