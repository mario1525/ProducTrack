using Data;
using Entity;
using System.Text;
using Services;
using Data.SQLClient;
using Middlewares;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;

// Configuración de las variables de entorno 
IConfiguration configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
    .Build();

string connectionString = configuration["Configuracion:connectionString"];
string SecretKey = configuration["Jwt:SecretKey"];
string Issuer = configuration["Jwt:Issuer"];
string Audience = configuration["Jwt:Audience"];


var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<SqlClient>(new SqlClient(connectionString));

//Data
builder.Services.AddSingleton<DaoCompania>();
builder.Services.AddSingleton<DaoUsuario>();
builder.Services.AddSingleton<DaoUsuarioCredential>();
builder.Services.AddSingleton<DaoArchivo>();
builder.Services.AddSingleton<DaoArchivoVal>();
builder.Services.AddSingleton<DaoLab>();
builder.Services.AddSingleton<DaoLabCamp>();
builder.Services.AddSingleton<DaoLabCampVal>();
builder.Services.AddSingleton<DaoOrden>();
builder.Services.AddSingleton<DaoOrdenCamp>();
builder.Services.AddSingleton<DaoOrdenCampVal>();
builder.Services.AddSingleton<DaoProcesEtap>();
builder.Services.AddSingleton<DaoProceso>();
builder.Services.AddSingleton<DaoProductCamp>();
builder.Services.AddSingleton<DaoProductCampVal>();
builder.Services.AddSingleton<DaoProducto>();
builder.Services.AddSingleton<DaoRegisLabProcesEtap>();
builder.Services.AddSingleton<DaoRegisOrden>();
builder.Services.AddSingleton<DaoRegisProduct>();
builder.Services.AddSingleton<DaoRegisProductProcesEtap>();

//Entity
builder.Services.AddSingleton<Compania>();
builder.Services.AddSingleton<Usuario>();
builder.Services.AddSingleton<Mensaje>();
builder.Services.AddSingleton<UsuarioCredential>();
builder.Services.AddSingleton<Login>();
builder.Services.AddSingleton<Token>();
builder.Services.AddSingleton<Archivo>();
builder.Services.AddSingleton<ArchivoVal>();
builder.Services.AddSingleton<Lab>();
builder.Services.AddSingleton<LabCamp>();
builder.Services.AddSingleton<LabCampVal>();
builder.Services.AddSingleton<Orden>();
builder.Services.AddSingleton<OrdenCamp>();
builder.Services.AddSingleton<OrdenCampVal>();
builder.Services.AddSingleton<Producto>();
builder.Services.AddSingleton<ProcesEtap>();
builder.Services.AddSingleton<Proceso>();
builder.Services.AddSingleton<CreateProces>();
builder.Services.AddSingleton<ProductCamp>();
builder.Services.AddSingleton<ProductCampVal>();
builder.Services.AddSingleton<Producto>();
builder.Services.AddSingleton<RegisLabProcesEtap>();
builder.Services.AddSingleton<RegisOrden>();
builder.Services.AddSingleton<RegisProduct>();
builder.Services.AddSingleton<RegisProductProcesEtap>();

//Services
builder.Services.AddSingleton<CompaniaLogical>();
builder.Services.AddSingleton<UsuarioLogical>();
builder.Services.AddSingleton<UsuarioCredentialLogical>();
builder.Services.AddSingleton<ProcesoLogical>();
builder.Services.AddSingleton<EtapaProcesoLogical>();

//Middlewares
builder.Services.AddSingleton<HashPassword>();
builder.Services.AddSingleton<GenerateToken>(new GenerateToken(SecretKey,Issuer,Audience));



// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddControllers();

// Add Cors
builder.Services.AddCors(options =>
{
    options.AddPolicy("MyPolicy",
        policy =>
        {
            policy.WithOrigins("http://localhost:4200")
                 .AllowAnyHeader()
                 .AllowAnyMethod();
        });
});

// swagger 
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configuración de la autenticación JWT
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = Issuer,
            ValidAudience = Audience,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(SecretKey))
        };
    });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseCors("MyPolicy");

// Middleware de autenticación y autorización
app.UseAuthentication();
app.UseAuthorization();

app.MapRazorPages();

// swagger 
app.UseSwagger();
app.UseSwaggerUI();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});

app.Run();
