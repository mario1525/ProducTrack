using Data;
using Data.SQLClient;
using Entity;
using Services;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Authentication.JwtBearer;
//using Microsoft.AspNetCore.Builder;

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
builder.Services.AddSingleton<DaoRegisOrden>();
builder.Services.AddSingleton<DaoArchivo>();
builder.Services.AddSingleton<DaoArchivoVal>();
builder.Services.AddSingleton<DaoLabCampVal>();
builder.Services.AddSingleton<DaoOrdenCampVal>();
builder.Services.AddSingleton<DaoProductCampVal>();
builder.Services.AddSingleton<DaoRegisLabProcesEtap>();
builder.Services.AddSingleton<DaoRegisProduct>();
builder.Services.AddSingleton<DaoRegisProductProcesEtap>();

//Entity
builder.Services.AddSingleton<RegisOrden>();
builder.Services.AddSingleton<Archivo>();
builder.Services.AddSingleton<ArchivoVal>();
builder.Services.AddSingleton<LabCampVal>();
builder.Services.AddSingleton<OrdenCampVal>();
builder.Services.AddSingleton<ProductCampVal>();
builder.Services.AddSingleton<RegisLabProcesEtap>();
builder.Services.AddSingleton<RegisProduct>();
builder.Services.AddSingleton<RegisProductProcesEtap>();

//Logical
builder.Services.AddSingleton<RegisOrdenLogical>();
builder.Services.AddSingleton<OrdenCampVaLogical>();
builder.Services.AddSingleton<RegisProductLogical>();
builder.Services.AddSingleton<RegisProductCampValLogical>();



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
