FROM eclipse-temurin:21-jre

WORKDIR /app

COPY target/rs-0.0.1-SNAPSHOT.war app.war

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.war"]
