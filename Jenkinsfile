pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS = credentials('azure-service-principal')

    stages {
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Plan & Apply') {
            steps {
                dir('terraform') {
                    bat 'terraform plan -out=tfplan'
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Publish .NET 8 Web API') {
            steps {
                dir('webapi') {
                    bat 'dotnet publish -c Release -o out'
                }
            }
        }

        stage('Deploy to Azure App Service') {
            steps {
                bat 'az login --service-principal -u %ARM_CLIENT_ID% -p %ARM_CLIENT_SECRET% --tenant %ARM_TENANT_ID%'
                bat 'az account set --subscription %ARM_SUBSCRIPTION_ID%'
                bat 'az webapp deploy --resource-group my-jenkins-rg --name myjenkinsappsvc123 --src-path webapi\\out --type zip'
            }
        }
    }
}
