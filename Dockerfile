FROM amazoncorretto:21-alpine-jdk
LABEL authors="maxl"
COPY target/*.war deploy.war

ENTRYPOINT ["java","-jar","/deploy.war"]