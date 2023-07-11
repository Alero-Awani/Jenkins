node {
    env.ANSIBLE_IP = '172.16.1.225'
    env.KUBE_IP = '172.16.1.100'

    stage('Git checkout'){
        git branch: 'main', url: 'https://github.com/Alero-Awani/Jenkins'
    }
    stage('Sending Dockerfile to Ansible Server over SSH'){
         sshagent(['Ansible']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP}"
            sh "scp /var/lib/jenkins/workspace/pipeline/* ubuntu@${ANSIBLE_IP}:/home/ubuntu"
            }
    }
    stage('Docker Build image'){
        sshagent(['Ansible']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} cd /home/ubuntu/"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} docker image build -t $JOB_NAME:v1.$BUILD_ID ."
        }
    }
    stage('Docker image tagging'){
        sshagent(['Ansible']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} cd /home/ubuntu/"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} docker image tag $JOB_NAME:v1.$BUILD_ID aleroawani/$JOB_NAME:v1.$BUILD_ID"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} docker image tag $JOB_NAME:v1.$BUILD_ID aleroawani/$JOB_NAME:latest"

        }
    }
    
    stage('Push Docker images to Dockerhub'){
        withCredentials([string(credentialsId: 'docker_pass', variable: 'docker_pass')]) {
            sshagent(['Ansible']) {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} docker login -u aleroawani -p ${docker_pass}"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} docker image push aleroawani/$JOB_NAME:v1.$BUILD_ID"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} docker image push aleroawani/$JOB_NAME:latest"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${ANSIBLE_IP} docker image rm aleroawani/$JOB_NAME:latest aleroawani/$JOB_NAME:v1.$BUILD_ID $JOB_NAME:v1.$BUILD_ID"
            }
            
        }

    }
    
    stage('Copy files from Ansible to Kubernetes'){
        sshagent(['Ansible-k8s']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${KUBE_IP}"
            sh "scp /var/lib/jenkins/workspace/pipeline/* ubuntu@${KUBE_IP}:/home/ubuntu"
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