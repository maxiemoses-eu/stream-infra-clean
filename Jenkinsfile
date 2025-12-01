pipeline {
  agent any

  environment {
    // Standard variables for the production environment
    AWS_REGION          = 'us-west-2'
    TF_VAR_environment  = 'prod'
    TF_VAR_region       = "${AWS_REGION}"
    // Set to the actual variable file name inside the prod directory
    TFVARS_FILE         = 'prod.tfvars' 
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Operations') {
      // --- SECURE CREDENTIAL INJECTION ---
      // 'AWS_PROD_CREDS' must be the ID of your configured AWS credential in Jenkins
      withCredentials([aws(credentialsId: 'AWS_PROD_CREDS', accesskeyVariable: 'AWS_ACCESS_KEY_ID', secretkeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        
        dir('environments/prod') {

          stage('Init') {
            steps {
              sh 'terraform init' 
            }
          }

          stage('Format & Validate') {
            steps {
              sh 'terraform fmt -check -recursive'
              sh 'terraform validate'
            }
          }

          stage('Plan') {
            steps {
              sh "terraform plan -var-file=${TFVARS_FILE}" 
            }
          }

          stage('Apply') {
            when {
              branch 'main'
            }
            steps {
              input message: 'Approve production deployment?'
              sh "terraform apply -auto-approve -var-file=${TFVARS_FILE}"
            }
          }
        }
      }
    }
  }

  post {
    always {
      echo 'Cleaning up local .terraform directory...'
      sh 'rm -rf environments/prod/.terraform' 
    }
    failure {
      mail to: 'devops@yourdomain.com',
           subject: "Terraform Pipeline Failed: ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
           body: "Check Jenkins for details: ${env.BUILD_URL}"
    }
  }
}