using Kalinar.Data.Database;
using Kalinar.Test.Seeding;

using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;

namespace Kalinar.Test.Factories
{
    public class KalinarWebApplicationFactory<TProgram>
        : WebApplicationFactory<TProgram> where TProgram : class
    {
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.ConfigureServices(services =>
            {
                ServiceDescriptor descriptor = services.Single(d => d.ServiceType == typeof(DbContextOptions<Context>));
                services.Remove(descriptor);
                //services.AddDbContext<Context>(options => options.UseSqlite("DataSource=file::memory:?cache=shared"));
                services.AddDbContext<Context>(options => options.UseInMemoryDatabase("Testing"));

                services.Configure<JwtBearerOptions>(
                JwtBearerDefaults.AuthenticationScheme,
                options =>
                {
                    options.Configuration = new OpenIdConnectConfiguration
                    {
                        Issuer = JwtTokenProvider.Issuer,
                    };

                    options.TokenValidationParameters.ValidIssuer = JwtTokenProvider.Issuer;
                    options.TokenValidationParameters.ValidAudience = JwtTokenProvider.Issuer;
                    options.Configuration.SigningKeys.Add(JwtTokenProvider.SecurityKey);
                });

                ServiceProvider provider = services.BuildServiceProvider();
                using (IServiceScope scope = provider.CreateScope())
                {
                    Context context = scope.ServiceProvider.GetRequiredService<Context>();

                    context.Database.EnsureDeleted();
                    context.Database.EnsureCreated();

                    Utilities.SeedDatabase(context);
                }
            });

            builder.UseEnvironment("Staging");
        }
    }
}
