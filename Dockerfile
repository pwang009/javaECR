# Stage 1: Build with Maven
FROM maven:3.8.6-openjdk-11-slim AS builder
WORKDIR /app
COPY pom.xml .
# Cache Maven dependencies (faster rebuilds)
RUN mvn dependency:go-offline
COPY src ./src
# Build the project
RUN mvn package -DskipTests

# Stage 2: Runtime with JRE only (no Maven needed)
FROM openjdk:8
# FROM openjdk:8-jre
# FROM openjdk:11-jre-slim

RUN apt-get update && apt-get upgrade -y
WORKDIR /app
# Copy only the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar
# Run the application
CMD ["java", "-jar", "app.jar"]
