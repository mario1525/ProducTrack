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

//Entity
builder.Services.AddSingleton<Compania>();
builder.Services.AddSingleton<Usuario>();
builder.Services.AddSingleton<Mensaje>();
builder.Services.AddSingleton<UsuarioCredential>();
builder.Services.AddSingleton<Login>();
builder.Services.AddSingleton<Token>();

//Services
builder.Services.AddSingleton<CompaniaLogical>();
builder.Services.AddSingleton<UsuarioLogical>();
builder.Services.AddSingleton<UsuarioCredentialLogical>();

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
            policy.WithOrigins("https://mine-to-plant.azurewebsites.net", "http://localhost:4200", "https://mine-to-plant.vercel.app", "https://mine-to-plant-dev.vercel.app")
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
