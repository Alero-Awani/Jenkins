node {
    stage('Git checkout'){
        git branch: 'main', url: 'https://github.com/Alero-Awani/Jenkins'
    }
    stage('Sending DockerFile to Ansible Server over ssh'){
        sshagent(['Ansible']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.198.243.237'
            sh 'scp /var/lib/jenkins/workspace/Pipeline/Dockerfile ubuntu@54.198.243.237:/home/ubuntu'

            }
    }
    stage('Docker build images'){
        sshagent(['Ansible']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.198.243.237 cd /home/ubuntu/'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.198.243.237 docker image build -t pipeline:v1.$BUILD_ID .'
        }
    }
}

#small change


// pipeline {
//     agent {
//         node {
//             stage('Git Checkout') 
//                 git branch: 'main', url: 'https://github.com/Alero-Awani/Jenkins'
//         }
//     }
// }





















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