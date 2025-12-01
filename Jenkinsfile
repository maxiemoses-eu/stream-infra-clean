pipeline {
  agent any

  environment {
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

    stage('Terraform Init') {
      steps {
        dir('environments/prod') {
          // REMOVED -backend-config FLAGS: Configuration is read from backend.tf
          sh 'terraform init' 
        }
      }
    }

    stage('Format & Validate') {
      steps {
        dir('environments/prod') {
          sh 'terraform fmt -check -recursive'
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('environments/prod') {
          // Using the correct variable file path
          sh "terraform plan -var-file=${TFVARS_FILE}" 
        }
      }
    }

    stage('Terraform Apply') {
      when {
        branch 'main'
      }
      steps {
        dir('environments/prod') {
          input message: 'Approve production deployment?'
          sh "terraform apply -auto-approve -var-file=${TFVARS_FILE}"
        }
      }
    }
  }

  post {
    always {
      // Clean up the local provider cache regardless of success/failure
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