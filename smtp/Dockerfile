# Usar la imagen oficial de Node.js como base
FROM node:18

# Crear y establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar el archivo package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias de la aplicación
RUN npm install --production

# Copiar el resto de los archivos de la aplicación
COPY . .

# Exponer el puerto que la aplicación utilizará
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["npm", "start"]
