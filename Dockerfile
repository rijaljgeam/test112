# Stage 1: Build the WAR using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy source code
COPY . .

# Build WAR file
RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat
FROM tomcat:9.0-jdk17

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from builder image
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

CMD ["catalina.sh", "run"]
