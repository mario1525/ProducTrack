### README

# ProducTrack

ProducTrack es una aplicación de gestión de productos diseñada para controlar el flujo normal de productos en una empresa. La aplicación permite la modificación de etapas, procesos y flujos específicos para cada producto, la captura de datos específicos, la realización de análisis o pruebas en cada etapa, y la adición de imágenes como evidencia. Los productos están enlazados a órdenes, las cuales a su vez están enlazadas a clientes, y cada orden tiene un responsable de su ejecución. Además, los usuarios pueden ser configurados con roles específicos para cada flujo o empresa.

## Características del Software

- **Gestión de Productos**: Permite controlar las etapas, procesos y flujos específicos para cada producto.
- **Datos Personalizados**: Configuración de los datos que se solicitan para cada producto.
- **Análisis y Pruebas**: Capacidad de realizar análisis o pruebas en cada etapa del proceso.
- **Evidencias con Imágenes**: Posibilidad de agregar imágenes como evidencias al producto.
- **Gestión de Órdenes**: Los productos están enlazados a órdenes, y cada orden puede tener múltiples productos.
- **Relación con Clientes**: Cada orden está enlazada a un cliente.
- **Responsables de Órdenes**: Asignación de responsables para la ejecución de cada orden.
- **Roles y Permisos**: Configuración de roles específicos para usuarios en cada flujo o empresa.

## Requisitos Previos

Para ejecutar este proyecto, necesitas tener instalados los siguientes componentes:

- .NET Core SDK 7.0
- SQL Server
- Node.js y npm (para el frontend)
- Angular CLI

## Configuración del Proyecto

### Backend

1. Clona el repositorio.
   ```sh
   git clone https://github.com/tu_usuario/productrack.git
   ```

2. Navega al directorio del backend.
   ```sh
   cd productrack/Backend
   ```

3. Restaura las dependencias del proyecto.
   ```sh
   dotnet restore
   ```

4. Configura la cadena de conexión a la base de datos en `appsettings.json`.
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=your_server;Database=your_database;User Id=your_user;Password=your_password;"
   }
   ```

5. En la carpeta `Backend/scripts`, encontrarás todos los scripts necesarios para crear la base de datos. Ejecuta estos scripts en tu servidor SQL.

6. Ejecuta las migraciones para crear las tablas de la base de datos.
   ```sh
   dotnet ef database update
   ```

7. Ejecuta el proyecto.
   ```sh
   dotnet run
   ```

### Frontend

1. Navega al directorio del frontend.
   ```sh
   cd productrack/Frontend
   ```

2. Instala las dependencias del proyecto.
   ```sh
   npm install
   ```

3. Ejecuta el servidor de desarrollo.
   ```sh
   ng serve
   ```

4. Abre tu navegador y navega a `http://localhost:4200`.

## Uso de la Aplicación

### Endpoints del Backend

El backend proporciona varios endpoints para gestionar compañías, órdenes y usuarios. A continuación se describen algunos de los endpoints principales:

- **GET /api/compania**: Obtiene la lista de compañías.
- **GET /api/compania/{id}**: Obtiene los detalles de una compañía específica.
- **POST /api/compania**: Crea una nueva compañía.
- **PUT /api/compania/{id}**: Actualiza una compañía existente.
- **DELETE /api/compania/{id}**: Elimina una compañía.
- **GET /api/orden**: Obtiene la lista de órdenes.
- **GET /api/orden/{id}**: Obtiene los detalles de una orden específica.
- **POST /api/orden**: Crea una nueva orden.
- **PUT /api/orden/{id}**: Actualiza una orden existente.
- **DELETE /api/orden/{id}**: Elimina una orden.
- **GET /api/usuario**: Obtiene la lista de usuarios.
- **GET /api/usuario/{id}**: Obtiene los detalles de un usuario específico.
- **POST /api/usuario**: Crea un nuevo usuario.
- **PUT /api/usuario/{id}**: Actualiza un usuario existente.
- **DELETE /api/usuario/{id}**: Elimina un usuario.

### Ejemplo de Ejecución de un Procedimiento Almacenado

Para ejecutar el procedimiento almacenado `dbo.dbSpCompaniaSet`, puedes usar el siguiente comando SQL:
```sql
EXEC dbo.dbSpCompaniaSet 
    @Id = '1', 
    @Nombre = 'Mi Compania', 
    @NIT = '123456789', 
    @Direccion = 'Calle Falsa 123', 
    @Estado = 1, 
    @Operacion = 'I';
```

## Seguridad y Autenticación

El backend utiliza JWT para la autenticación y autorización de usuarios. A continuación se muestra un ejemplo de generación de un token JWT:
```csharp
var claims = new[]
{
    new Claim(JwtRegisteredClaimNames.Sub, user.Nombre),
    new Claim(ClaimTypes.Role, user.Rol),
    new Claim("IdCompania", user.IdCompania),
    new Claim(ClaimTypes.NameIdentifier, user.Id),
    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
    // Puedes agregar más claims según tus necesidades
};

var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"]));
var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

var token = new JwtSecurityToken(
    issuer: configuration["Jwt:Issuer"],
    audience: configuration["Jwt:Audience"],
    claims: claims,
    expires: DateTime.Now.AddMinutes(30),
    signingCredentials: creds);

return new JwtSecurityTokenHandler().WriteToken(token);
```

### Restricción de Endpoints por Roles

Puedes restringir el acceso a ciertos endpoints en el backend utilizando atributos de autorización. Por ejemplo:
```csharp
[Authorize(Roles = "Admin,Manager")]
[HttpPost("create")]
public IActionResult Create([FromBody] Compania compania)
{
    // Código para crear una compañía
}
```

## Pruebas

Para ejecutar las pruebas del backend, utiliza el siguiente comando:

```sh

dotnet test
```

Para ejecutar las pruebas del frontend, utiliza:


```sh

ng test
```

## Despliegue

Para desplegar la aplicación en producción, sigue los pasos específicos para tu entorno de despliegue (Azure, AWS, Heroku, etc.). Aquí hay un ejemplo básico de despliegue en Azure:

1. Publica el proyecto:

```sh

dotnet publish -c Release -o ./publish
```

2. Sube los archivos publicados a tu servicio de Azure.

3. Configura las variables de entorno necesarias para la base de datos y otros servicios.

## Contribuir

Si deseas contribuir a este proyecto, por favor sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una rama para tu feature (`git checkout -b feature/nueva-feature`).
3. Haz commit de tus cambios (`git commit -am 'Agrega nueva feature'`).
4. Haz push a la rama (`git push origin feature/nueva-feature`).
5. Abre un Pull Request.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## Contacto

Si tienes alguna pregunta o sugerencia, no dudes en abrir un issue o contactarnos a través de nuestro correo electrónico: [mbeltran4892@gmail.com](mailto:mbeltran4892@gmail.com).

¡Gracias por usar ProducTrack!