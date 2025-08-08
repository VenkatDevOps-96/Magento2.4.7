pipeline {
  agent any

  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-creds')   // Jenkins credential ID for AWS Access Key
    AWS_SECRET_ACCESS_KEY = credentials('aws-creds') // Jenkins credential ID for AWS Secret Key
    AWS_DEFAULT_REGION    = 'us-east-1'                        // your AWS region
  }

  stages {
    stage('Checkout') {
      steps {
        // Replace URL with your Terraform repo URL
        git url: 'https://github.com/VenkatDevOps-96/Magento2.4.7.git', branch: 'main'
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: 'Do you want to apply the Terraform changes?'
        sh 'terraform apply -auto-approve tfplan'
      }
    }
  }

  post {
    success {
      echo 'Terraform applied successfully!'
    }
    failure {
      echo 'Terraform deployment failed.'
    }
  }
}

