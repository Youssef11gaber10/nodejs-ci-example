pipeline {
    agent any

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
        stage("build docker image") {
            steps {

                    sh 'docker version'
//fetch username from cerdentials and put it in variable called DOCKER_USERNAME & password fetch from cerdentials and put it in variable called DOCKER_PASSWORD
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credential-id',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    }

                    sh '''
                        docker build -t youssef11gaber10/jenkins-nodeapp:latest .
                        docker push youssef11gaber10/jenkins-nodeapp:latest
                    '''
            }
}






            // post {
            //     // If Maven was able to run the tests, even if some of the test
            //     // failed, record the test results and archive the jar file.
            //     success {
            //         junit '**/target/surefire-reports/TEST-*.xml'
            //         archiveArtifacts 'target/*.jar'
            //     }


        }//stages
    }//pipeline

