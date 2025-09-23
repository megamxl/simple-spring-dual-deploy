pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'tomcat-creds', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASS')]) {
                    sh '''
                        curl -u $TOMCAT_USER:$TOMCAT_PASS \
                          --upload-file target/*.war \
                          "http://10.0.0.58:8666/manager/text/deploy?path=/app&update=true"
                    '''
                }
        }
    }
}
