# ETAPA 1: Construcción
# "Trae una imagen que ya tiene Java 17 Y Maven instalados"
FROM maven:3.9-eclipse-temurin-17-alpine AS builder
WORKDIR /app
# "Copia solo el pom.xml primero para descargar dependencias"
COPY pom.xml .
RUN mvn dependency:go-offline -B
# "Ahora copia el código fuente"
COPY src src
# "Compila y empaqueta el proyecto"
RUN mvn package -DskipTests -B

# ETAPA 2: Ejecución
# "Imagen liviana solo para ejecutar, sin Maven"
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /app/target/*.jar app.jar
USER appuser
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]