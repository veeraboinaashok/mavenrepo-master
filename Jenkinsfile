pipeline{
    agent any
    environment {
    AWS_ACCESS_KEY_ID = credentials('Acesskey')
    AWS_SECRET_ACCESS_KEY = credentials('Screatkey')
    AWS_DEFAULT_REGION = 'ap-northeast-1'
       
  }
stages{
  stage('CheckOutCode'){
    steps{
   checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/veeraboinaashok/mavenrepo-master.git']])
	
	}
  }

  stage('Build'){
    steps{
       sh  "mvn clean package"
         }
   }
	
   stage('sonarQube'){
    steps{
       sh  "mvn clean sonar:sonar"
         }
   }
 stage('nexus'){
    steps{
       sh  "mvn clean deploy"
         }
   }
   
   stage('upload in ecr') {
	 steps {
	   script {
	          
	  withCredentials([string(credentialsId: 'Acesskey', variable: 'Acesskey'), 
	  string(credentialsId: 'Screatkey', variable: 'Screatkey')]) {
          sh 'aws configure set aws_access_key_id $Acesskey'
          sh 'aws configure set aws_secret_access_key $Screatkey'
          sh 'aws configure set default.region $AWS_DEFAULT_REGION'
          
          // Perform other AWS-related commands or actions here
    sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/k0d1g4g8'
    sh 'docker build -t ashokrepo .'
    sh 'docker tag ashokrepo:latest public.ecr.aws/k0d1g4g8/ashokrepo:latest'
    sh 'docker push public.ecr.aws/k0d1g4g8/ashokrepo:latest'
        }
}
}
}
stage(deployECRimageintoECS){
    steps{
        script{
          sh 'aws ecs update-service --cluster arn:aws:ecs:ap-northeast-1:164506155255:cluster/ashok-cluster --service arn:aws:ecs:ap-northeast-1:164506155255:service/ashok-cluster/ashok-service --force-new-deployment'
        }
    }
}
}
}
   
