# ============================================================
# Stage 1: Build with Maven
# ============================================================
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B -DskipTests

COPY src ./src
RUN mvn clean package -DskipTests

# ============================================================
# Stage 2: Run with JRE
# ============================================================
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

RUN mkdir -p /app/uploads /app/service-logs

EXPOSE 8099

ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=${SPRING_PROFILE:default}"]
