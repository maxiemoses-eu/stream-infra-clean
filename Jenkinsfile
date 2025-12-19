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

    stage('Terraform Plan') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'AWS_INFRA_CREDS',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          dir('environments/prod') {
            script {
              sh 'terraform init -input=false -reconfigure'
              sh 'terraform workspace select prod || terraform workspace new prod'
              sh 'terraform validate'
              sh "terraform plan -var-file=${TFVARS_FILE} -out=tfplan"
              archiveArtifacts artifacts: 'tfplan', fingerprint: true
            }
          }
        }
      }
    }

    stage('Terraform Apply') {
      // This stage will wait for you to click "Proceed" in Jenkins
      input {
        message "Do you want to apply the plan and build StreamlinePay Infra?"
        ok "Apply Changes"
      }
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'AWS_INFRA_CREDS',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          dir('environments/prod') {
            sh 'terraform apply -auto-approve tfplan'
          }
        }
      }
    }
  }

  post {
    always {
      echo '🧹 Cleaning up Terraform artifacts...'
      // Note: We keep .terraform but remove the sensitive plan file
      sh 'rm -f environments/prod/tfplan'
    }
    success {
      echo '✅ StreamlinePay Infrastructure build completed successfully.'
    }
    failure {
      echo '❌ Infrastructure build failed. Check AWS console and Jenkins logs.'
    }
  }
}