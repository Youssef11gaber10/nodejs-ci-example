@Library('my_custom_shared_library') _ // the _ after import is syntax 
pipeline {
    agent any
// agent {
//     label 'ec2-self-hosted-runner'
// }

    // tools {
    //     // Install the Maven version configured as "M3" and add it to the path.
    //     // maven "M3" # i don't want to install maven on agent 
    //     // i will build with docker so i want install docker on agent and make containr have docker cli and 
    // }

    stages {


        stage('preparation') {
                steps {
                    // Get some code from a GitHub repository
                    // git 'https://github.com/Youssef11gaber10/jenkins-test.git'
                    //jenins will pull ci file from github
                    // also will git clone the repo to workspace 
                    sh 'ls -lah'//check if he fetch the  repo from github

                    //now we need to docker build the docker image in that code so we need to have docker on ower agent 
                    // so we need install docker on our agent but we don't use it directly we make container and bind mount docker socket to container 
                    //or use docker-in-docker dind service inside container you will create or use kaniko to build the image inside container 
                    // but we don't build docker in agent machine itself because of security docker is root priviledge service

                }
            }
        // stage("build docker image") {
        //     steps {

        //         sh 'docker version'
        //                                     //fetch username from cerdentials and put it in variable called DOCKER_USERNAME & password fetch from cerdentials and put it in variable called DOCKER_PASSWORD
        //         withCredentials([usernamePassword(credentialsId: 'dockerhub-credential-id', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) // this will be at level of this command only 
        //         {sh 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'}

        //         sh '''
        //         docker build -t youssef11gaber10/jenkins-nodeapp:latest . 
        //         docker push youssef11gaber10/jenkins-nodeapp:latest
        //         '''

        //     }
        // }




// build normally 
//         stage("build docker image") {
//             steps {
//                     sh 'newgrp docker'

//                     sh 'docker version'
// //fetch username from cerdentials and put it in variable called DOCKER_USERNAME & password fetch from cerdentials and put it in variable called DOCKER_PASSWORD
//                     withCredentials([usernamePassword(
//                         credentialsId: 'dockerhub-credential-id',
//                         usernameVariable: 'DOCKER_USERNAME',
//                         passwordVariable: 'DOCKER_PASSWORD'
//                     )]) {
//                         sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
//                     }

//                     sh '''
//                         docker build -t youssef11gaber10/jenkins-nodeapp:latest .
//                         docker push youssef11gaber10/jenkins-nodeapp:latest
//                     '''
//             }
// }


// build with components 





stage("build docker image "){
    steps{
        // def call (String repo_name="youssef11gaber10/jenkins-nodeapp",String tag="latest", String credentialsId="dockerhub-credential-id"){  // make your input and this is default value

            // name of function here isn't call , it named with name of hte file dockerize.groovy
            script{

            // dockerize(repo_name: "youssef11gaber10/jenkins-nodeapp", tag: "v2", credentialsId: "dockerhub-credential-id") // done 
            dockerize( "youssef11gaber10/jenkins-nodeapp", "v2","dockerhub-credential-id")
            }
    }
}

stage("deploy") {
    // agent {label 'ec2-self-hosted-runner'}
    steps {

         withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credential-id',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    }

        //run the container
        // we use daemon of my laptop this container will run on my laptop
        sh 'docker run -d -p 3000:3000 youssef11gaber10/jenkins-nodeapp:latest'

    }

// inside stage of deploy 
            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                // these are pre-defined variables in jenkins pipeline
                success {
                    slackSend (color: '#00FF00',message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                }

                failure {
                    slackSend (color: '#FF0000',message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                }
            }

}

        }//stages
    }//pipeline

