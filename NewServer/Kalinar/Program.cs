using Kalinar.Application.Extensions;
using Kalinar.Data.Extensions;
using Kalinar.ErrorHandling;
using Kalinar.Extensions;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddAndConfigureVersioning(new ApiVersioningErrorResponseProvider());

builder.Services.AddApplicationPolicies();
builder.Services.AddFirebaseAuthentication();
builder.Services.AddApplicationLayer();
builder.Services.AddDataLayer(builder.Configuration.GetConnectionString("Database")!);

WebApplication app = builder.Build();

app.UseMiddleware<ExceptionMIddleware>();
app.UseMiddleware<AuthenticationMiddleware>();

app.UseSwagger();
app.UseSwaggerUIWithVersioning();

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

await app.UseDatabaseMigrations();
await app.RunAsync();