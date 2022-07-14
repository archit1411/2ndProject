pipeline{
    agent any
    stages{
        stage('cloning a git repo'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/archit1411/2ndProject']]])
            }
        }
        stage('Building an image'){
            steps{
                script{
                    app=docker.build("armalhot/2ndproject")
                }
                
            }
        }
        stage('Pushing to Hub'){
            steps{
                script{
                    docker.withRegistry('https://registry.hub.docker.com','docker_hub_login'){
                        app.push("$env.BUILD_NUMBER")
                    }
                }
            }
        }
        stage('Running Playbook'){
			steps{
				ansiblePlaybook credentialsId: 'ansible', installation: 'ansible', inventory: 'inventory.ini', playbook: 'copying.yml'
			}
		}
        stage('logging in'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'web', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script{
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@18.142.115.160 \"docker pull armalhot/2ndproject:${env.BUILD_NUMBER}\""
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@18.142.115.160 \"docker run --restart always --name train-schedule -p 8080:8080 -d armalhot/2ndproject:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
}
