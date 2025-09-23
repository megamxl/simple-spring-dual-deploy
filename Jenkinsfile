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
                deploy adapters: [
                        tomcat10(
                            credentialsId: 'tomcat-creds',
                            url: 'http://10.0.0.1:8666/'
                        )
                    ],
                    war: 'target/*.war',
                    contextPath: 'app'
            }
        }
    }
}
