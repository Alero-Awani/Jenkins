pipeline {
    agent {
        node {
            stage('Git Checkout') 
                git branch: 'main', url: 'https://github.com/Alero-Awani/Jenkins'
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