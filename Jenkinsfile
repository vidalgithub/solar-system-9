pipeline {
  agent any

  environment {
    NAME = "solar-system"
    VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
    IMAGE_REPO = "vidaldocker"
    //ARGOCD_TOKEN = credentials('argocd-token')
    GITHUB_TOKEN = credentials('github-token')
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
            sh "docker build -t ${NAME} ."
            sh "docker tag ${NAME}:latest ${IMAGE_REPO}/${NAME}:${VERSION}"
        }
      }

    stage('Push Image') {
      steps {
        withVault(configuration: [disableChildPoliciesOverride: false, timeout: 60, vaultCredentialId: 'vaultCred', vaultUrl: 'http://vault.beitcloud.com:8200'], vaultSecrets: [[path: 'dockerhub/creds', secretValues: [[vaultKey: 'username'], [vaultKey: 'password']]]]) {
          sh 'docker push ${IMAGE_REPO}/${NAME}:${VERSION}'
        }
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
          sh 'sed -i "s#vidaldocker.*#${IMAGE_REPO}/${NAME}:${VERSION}#g" deployment.yaml'
          sh 'cat deployment.yaml'
        }
      }
    }

    stage('Commit & Push') {
      steps {
        dir("gitops-argocd/jenkins-demo") {
          withVault {
              sh "git config --global user.email 'jenkins@ci.com'"
              sh 'git remote set-url origin http://$GITHUB_TOKEN@github.com/vidalgithub/gitops-argocd.git'
              sh 'git checkout feature'
              sh 'git add -A'
              sh 'git commit -am "Updated image version for Build - $VERSION"'
              sh 'git push origin feature'
          }
        }
      }
    }

    stage('Raise PR') {
      agent {
        docker { image 'trussworks/gh-cli:dependabot-docker-cimg-python-3.10.6' }
      }
      steps {
        sh "bash prq.sh"
      }
    } 
  }
}
