pipeline {
  agent any

  environment {
    // Environment-specific variables
    AWS_REGION          = 'us-west-2'
    TF_VAR_environment  = 'prod'
    TF_VAR_region       = "${AWS_REGION}"
    TFVARS_FILE         = 'prod.tfvars'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Operations') {
      environment {
        // Inject AWS credentials securely
        AWS_ACCESS_KEY_ID     = credentials('AWS_PROD_CREDS')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_PROD_CREDS')
      }

      steps {
        dir('environments/prod') {
          script {
            // Select or create workspace
            sh 'terraform workspace select prod || terraform workspace new prod'

            // Terraform Init
            sh 'terraform init -input=false'

            // Format & Validate
            sh 'terraform fmt -check -recursive'
            sh 'terraform validate'

            // Plan with output file
            sh "terraform plan -var-file=${TFVARS_FILE} -out=tfplan"

            // Archive plan file for auditing
            archiveArtifacts artifacts: 'tfplan', fingerprint: true

            // Manual approval before apply
            if (env.BRANCH_NAME == 'main') {
              input message: 'Approve production deployment?'
              sh 'terraform apply -auto-approve tfplan'
            }
          }
        }
      }
    }
  }

  post {
    always {
      echo 'Cleaning up Terraform artifacts...'
      sh 'rm -rf environments/prod/.terraform environments/prod/tfplan'
    }

    success {
      echo '✅ Terraform apply completed successfully.'
      // Optional: Slack or other notification
      // slackSend channel: '#infra-alerts', message: "✅ Terraform apply succeeded for ${env.JOB_NAME} [${env.BUILD_NUMBER}]"
    }

    failure {
      echo '❌ Terraform apply failed.'
      mail to: 'devops@yourdomain.com',
           subject: "Terraform Pipeline Failed: ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
           body: "Check Jenkins for details: ${env.BUILD_URL}"
      // Optional: Slack alert
      // slackSend channel: '#infra-alerts', message: "❌ Terraform apply failed for ${env.JOB_NAME} [${env.BUILD_NUMBER}]"
    }
  }
}
