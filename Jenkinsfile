pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

         stage('Update Config') {
             steps {
                def jsonPayload = """
                {
                  "file_path": "/etc/tomcat10/Catalina/localhost/app.xml",
                  "store_name": "vault",
                  "secret_wrapper": {
                    "content": "<Context>\\n   <Environment name=\\"env.name\\" value=\\"{{ .name }}\\" type=\\"java.lang.String\\" override=\\"false\\" />\\n</Context> \\n",
                    "secret_references": {
                      "name": "global/name"
                    }
                  }
                }
                """

                sh """curl -v -X POST http://10.0.0.59:8090/create \
                  -H "Content-Type: application/json" \
                  -d '${jsonPayload}'"""
             }
        }
        stage('Deploy to Tomcat') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'tomcat-creds', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASS')]) {
                    sh '''
                        curl -u $TOMCAT_USER:$TOMCAT_PASS \
                          --upload-file target/*.war \
                          "http://10.0.0.59:8080/manager/text/deploy?path=/app&update=true"
                    '''
                }
            }
        }
    }
}
