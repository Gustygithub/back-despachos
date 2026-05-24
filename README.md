# Springboot-API-REST-DESPACHO

API REST desarrollada con Spring Boot 3.4.4 y Java 17 para la gestión de despachos de Innovatech Chile.

## Tecnologías utilizadas

- Java 17
- Spring Boot 3.4.4
- MySQL 8.0
- Docker (multi-stage build)
- GitHub Actions (CI/CD)

## Requisitos previos

- Docker Desktop instalado
- Java 17 (solo para desarrollo local)

## Cómo ejecutar con Docker

### 1. Clonar el repositorio
```bash
git clone https://github.com/Gustygithub/back-despachos.git
cd back-despachos
```

### 2. Construir la imagen
```bash
docker build -t back-despachos .
```

### 3. Ejecutar el contenedor
```bash
docker run -d --name back_despachos \
  -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql_db:3306/despachos_db \
  -e SPRING_DATASOURCE_USERNAME=appuser \
  -e SPRING_DATASOURCE_PASSWORD=apppass \
  -p 8081:8081 \
  back-despachos
```

## Ejecutar stack completo con Docker Compose
```bash
docker-compose up -d
```

## Pipeline CI/CD

El pipeline se activa automáticamente con cada push a la rama `deploy` y realiza:

1. **Build** → Construye la imagen Docker
2. **Push** → Publica la imagen en Docker Hub
3. **Deploy** → Despliega automáticamente en EC2

## Persistencia de datos

Se utiliza **named volume** (`mysql_data`) para persistir los datos de MySQL. Esto garantiza que la información no se pierda al reiniciar los contenedores.

## Estructura del proyecto 
├── src/                    # Código fuente
├── .github/
│   └── workflows/
│       └── deploy.yml      # Pipeline CI/CD
├── Dockerfile              # Multi-stage build
├── docker-compose.yml      # Stack completo
└── README.md
## Despliegue en AWS EC2

La aplicación está desplegada en una instancia EC2 de Amazon Linux 2023 con Docker instalado. Solo el Frontend es accesible desde Internet, el Backend opera en subred privada.