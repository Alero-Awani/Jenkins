node {
    stage('Git checkout'){
        git branch: 'main', url: 'https://github.com/Alero-Awani/Jenkins'
    }
    stage('Sending Dockerfile to Ansible Server over SSH'){
         sshagent(['Ansible']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144'
            sh 'scp /var/lib/jenkins/workspace/pipeline/Dockerfile ubuntu@34.229.226.144:/home/ubuntu'
            }
    }
    stage('Docker Build image'){
        sshagent(['Ansible']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 cd /home/ubuntu/'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker image build -t $JOB_NAME:v1.$BUILD_ID .'
        }
    }
    stage('Docker image tagging'){
        sshagent(['Ansible']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 cd /home/ubuntu/'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker image tag $JOB_NAME:v1.$BUILD_ID aleroawani/$JOB_NAME:v1.$BUILD_ID'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker image tag $JOB_NAME:v1.$BUILD_ID aleroawani/$JOB_NAME:latest'

        }
    }
    stage('Push Docker images to Dockerhub'){
        sshagent(['Ansible']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 cd /home/ubuntu/'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker image tag $JOB_NAME:v1.$BUILD_ID aleroawani/$JOB_NAME:v1.$BUILD_ID'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker image tag $JOB_NAME:v1.$BUILD_ID aleroawani/$JOB_NAME:latest'

        }
    }
    stage('Push Docker images to Dockerhub'){
        withCredentials([string(credentialsId: 'docker_pass', variable: 'docker_pass')]) {
            sshagent(['Ansible']) {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker login -u aleroawani -p ${docker_pass}"
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker image push aleroawani/$JOB_NAME:v1.$BUILD_ID '
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@34.229.226.144 sudo docker image push aleroawani/$JOB_NAME:latest'
            }
            
        }

    }
    
}






















// pipeline {
//     agent { 
//         node {
//             label 'docker-agent-python'
//             }
//       }
//     triggers {
//         pollSCM '*/5 * * * *'
//     }
//     stages {
//         stage('Build') {
//             steps {
//                 echo "Building the new stuff.."
//                 sh '''
//                 cd myapp
//                 pip install -r requirements.txt
//                 '''
//             }
//         }
//         stage('Test') {
//             steps {
//                 echo "Testing.."
//                 sh '''
//                 cd myapp
//                 python3 hello.py
//                 python3 hello.py --name=Alero
//                 '''
//             }
//         }
//         stage('Deliver') {
//             steps {
//                 echo 'Deliver....'
//                 sh '''
//                 echo "doing delivery stuff.."
//                 '''
//             }
//         }
//     }
// }