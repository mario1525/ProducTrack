# Etapa 1: Construcción
FROM node:18 AS builder

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de configuración de dependencias
COPY package*.json ./

# Instala las dependencias del proyecto
RUN npm install

# Copia todos los archivos del proyecto al directorio de trabajo del contenedor
COPY . .

# Construye la aplicación NestJS
RUN npm run build

# Etapa 2: Imagen final
FROM node:16

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos necesarios desde la etapa de construcción
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

# Expone el puerto en el que la aplicación estará escuchando
EXPOSE 3204

# Define el comando por defecto para ejecutar la aplicación
CMD ["node", "dist/main.js"]

