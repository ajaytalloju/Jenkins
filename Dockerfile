# Use an official OpenJDK image that supports ARM64 architecture
FROM arm64v8/openjdk:11-jdk-slim AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the Maven POM file and the source code
COPY pom.xml .
COPY src ./src

# Run Maven to build the application
RUN apt-get update && apt-get install -y maven \
    && mvn clean package -DskipTests

# Use a smaller base image for the final stage
FROM arm64v8/openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port (if applicable)
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

