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
                 deploy adapters: [tomcat10(url: 'http://10.0.0.:8666/', credentialsId: 'tomcat-creds')],
                                  war: 'target/*.war',
                                  contextPath: 'app'
                }
            }
        }
    }
}
