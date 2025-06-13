# Use official OpenJDK 8 image
FROM openjdk:8

# Set working directory
WORKDIR /app

# Copy the built JAR file (with dependencies)
COPY target/hello-world-api-1.0.0-jar-with-dependencies.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]