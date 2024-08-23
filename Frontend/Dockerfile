# Etapa 1: Compilación
FROM node:16 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de los archivos de la aplicación
COPY . .

# Compila la aplicación Angular
RUN npm run build --prod

# Etapa 2: Servir la aplicación
FROM nginx:alpine

# Copia los archivos compilados desde la etapa de compilación
COPY --from=build /app/dist/frontend /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto en el que el servidor estará corriendo
EXPOSE 4200

# Comando para correr nginx
CMD ["nginx", "-g", "daemon off;"]
