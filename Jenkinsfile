pipeline {
  agent any

  environment {
    AWS_REGION         = 'us-west-2'
    TF_VAR_environment = 'prod'
    TF_VAR_region      = "${AWS_REGION}"
    TFVARS_FILE        = 'prod.tfvars'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Operations') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'AWS_INFRA_CREDS',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          dir('environments/prod') {
            script {
              // Initialize backend
              sh 'terraform init -input=false -reconfigure'
'

              // Select or create workspace
              sh 'terraform workspace select prod || terraform workspace new prod'

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
  }

  post {
    always {
      echo '🧹 Cleaning up Terraform artifacts...'
      sh 'rm -rf environments/prod/.terraform environments/prod/tfplan'
    }

    success {
      echo '✅ Terraform apply completed successfully.'
      // slackSend channel: '#infra-alerts', message: "✅ Terraform apply succeeded for ${env.JOB_NAME} [${env.BUILD_NUMBER}]"
    }

    failure {
      echo '❌ Terraform apply failed.'
      // Uncomment and configure SMTP to enable email alerts
      // mail to: 'devops@yourdomain.com',
      //      subject: "Terraform Pipeline Failed: ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
      //      body: "Check Jenkins for details: ${env.BUILD_URL}"
      // slackSend channel: '#infra-alerts', message: "❌ Terraform apply failed for ${env.JOB_NAME} [${env.BUILD_NUMBER}]"
    }
  }
}
