# Use a prebuilt OpenJDK image (Java already installed)
FROM openjdk:24

# Set working directory in container
WORKDIR /app

# Copy the built Spring Boot jar into the container
COPY target/user-service-1.0-SNAPSHOT.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

