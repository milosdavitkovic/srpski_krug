# Srpski Krug

Spring Boot + Thymeleaf web application. The Teamleaf profile page is available at `/` and `/home`.

### Run locally

```text
./mvnw spring-boot:run
```

Open `http://localhost:8080`.

For local HTTPS, run with the `local-https` profile and open `https://localhost:8080`:

```text
./mvnw spring-boot:run -Dspring-boot.run.profiles=local-https
```

The HTTPS profile uses the development-only self-signed certificate in the application resources, so the browser will show a certificate warning. Do not use that certificate in production.

### Docker

Build the application and image, then start it with:

```text
./mvnw package -DskipTests
docker compose up --build
```

The development Compose deployment uses HTTPS and listens on `https://localhost:8080`.
