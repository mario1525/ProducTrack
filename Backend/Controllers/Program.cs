using Data;
using Entity;
using System.Text;
using Services;
using Data.SQLClient;
//using Middlewares;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;

// Configuraci�n de las variables de entorno 
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
builder.Services.AddSingleton<DaoOrden>();
builder.Services.AddSingleton<DaoProceso>();
builder.Services.AddSingleton<DaoProductCamp>();
builder.Services.AddSingleton<DaoOrdenCamp>();
builder.Services.AddSingleton<DaoProcesEtap>();
builder.Services.AddSingleton<DaoProducto>();
builder.Services.AddSingleton<DaoProyecto>();


//Entity
builder.Services.AddSingleton<Compania>();
builder.Services.AddSingleton<VistaCompania>();
builder.Services.AddSingleton<Usuario>(); //
builder.Services.AddSingleton<Mensaje>();
builder.Services.AddSingleton<Token>(); //
builder.Services.AddSingleton<Orden>();
builder.Services.AddSingleton<Producto>();
builder.Services.AddSingleton<ProcesEtap>();
builder.Services.AddSingleton<Proceso>();
builder.Services.AddSingleton<CreateProduct>();
builder.Services.AddSingleton<CreateProces>();
builder.Services.AddSingleton<CreateOrden>();
builder.Services.AddSingleton<ProductCamp>();
builder.Services.AddSingleton<OrdenCamp>();
builder.Services.AddSingleton<Producto>();
builder.Services.AddSingleton<Proyecto>();
builder.Services.AddSingleton<etapas>();


//Services
builder.Services.AddSingleton<CompaniaLogical>();
builder.Services.AddSingleton<ProcesoLogical>();
builder.Services.AddSingleton<ProductLogical>();
builder.Services.AddSingleton<ProyectoLogical>();
builder.Services.AddSingleton<ProductCampLogical>();
builder.Services.AddSingleton<OrdenLogical>();
builder.Services.AddSingleton<OrdenCampLogical>();
builder.Services.AddSingleton<EtapaProcesoLogical>();

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddControllers();

// Add Cors
builder.Services.AddCors(options =>
{
    options.AddPolicy("MyPolicy",
        policy =>
        {
            policy.WithOrigins("http://localhost:4200 , http://localhost:3000")
                 .AllowAnyHeader()
                 .AllowAnyMethod();
        });
});

// swagger 
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configuraci�n de la autenticaci�n JWT
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

// Middleware de autenticaci�n y autorizaci�n
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
