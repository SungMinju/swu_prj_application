# Step 1: Build the jar file
FROM gradle:7.5.1-jdk17 AS build
WORKDIR /app
COPY . /app
RUN gradle clean build || true

# Step 2: Run the jar file
FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/build/libs/*.jar /app/app.jar
COPY --from=build /app/build/reports/tests/test/index.html /app/test-report.html
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
