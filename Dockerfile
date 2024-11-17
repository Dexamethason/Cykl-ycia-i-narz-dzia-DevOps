# Etap budowania aplikacji
FROM maven:3.8.7-openjdk-17-slim AS builder

# Ustaw katalog roboczy
WORKDIR /app

# Skopiuj pliki projektu do kontenera
COPY . .

# Buduj aplikację
RUN mvn clean package -DskipTests

# Etap uruchamiania aplikacji
FROM openjdk:17-jdk-slim

# Ustaw katalog roboczy
WORKDIR /app

# Skopiuj zbudowany plik JAR z poprzedniego etapu
COPY --from=builder /app/target/*.jar app.jar

# Eksponuj port aplikacji
EXPOSE 8080

# Uruchom aplikację
ENTRYPOINT ["java", "-jar", "app.jar"]
