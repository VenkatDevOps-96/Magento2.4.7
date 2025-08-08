pipeline {
  agent any

  stages {
    stage('Terraform Init') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-creds', 
                                         usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                         passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-creds', 
                                         usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                         passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh 'terraform plan -out=tfplan'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-creds', 
                                         usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                         passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh 'terraform apply -auto-approve tfplan'
        }
      }
    }
  }
}

