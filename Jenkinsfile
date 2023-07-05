node {
    stage('Git checkout'){
        git branch: 'main', url: 'https://github.com/Alero-Awani/Jenkins'
    }
    // stage('Adding Known Host'){
    //     tryAddKnownHost('172.16.1.123')  
    // }
    stage('Sending DockerFile to Ansible Server over ssh'){
        sshagent(['Ansible-server']) {
            sh 'ssh -o StrictHostKeyChecking=no -l ubuntu@172.16.1.123'
            sh 'scp /var/lib/jenkins/workspace/Pipeline-demo/* ubuntu@172.16.1.123:/home/ubuntu'
            }
    }
}

void tryAddKnownHost(String hostUrl){
    // ssh-keygen -F ${hostUrl} will fail (in bash that means status code != 0) if ${hostUrl} is not yet a known host
    def statusCode = sh script:"ssh-keygen -F ${hostUrl}", returnStatus:true
    if(statusCode != 0){
        sh "mkdir -p ~/.ssh"
        sh "ssh-keyscan ${hostUrl} >> ~/.ssh/known_hosts"
    }
}















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