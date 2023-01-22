
using Hero.Server.Core.Configuration;
using Hero.Server.DataAccess.Extensions;
using Hero.Server.Extensions;
using Hero.Server.Identity;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.Configure<S3Options>(options => builder.Configuration.GetSection("Services:S3").Bind(options));

builder.Services.AddJwtBearerAuthentication();
builder.Services.AddDataAccessLayer(builder.Configuration.GetConnectionString("Default"));
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddSwaggerForAuthentication();

WebApplication app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(options => {
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "API V1");
    options.RoutePrefix = String.Empty; 
});

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

await app.MigrateDatabaseAsync();
await app.EnsureGlobalAttributesExists();

app.UseExceptionHandler("/error");

app.InitializeFirebase();
app.Run();
