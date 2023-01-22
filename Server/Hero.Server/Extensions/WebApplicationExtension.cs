using FirebaseAdmin;

using Google.Apis.Auth.OAuth2;

using Hero.Server.Core;
using Hero.Server.Core.Database;
using Hero.Server.Core.Repositories;

namespace Hero.Server.Extensions
{
    public static class WebApplicationExtension
    {
        public static async Task EnsureGlobalAttributesExists(this WebApplication app)
        {
            using (IServiceScope scope =  app.Services.CreateScope())
            {
                IGroupContextBuilder builder = scope.ServiceProvider.GetRequiredService<IGroupContextBuilder>();
                IAttributeRepository repository = scope.ServiceProvider.GetRequiredService<IAttributeRepository>();

                builder.Apply(new Guid());

                foreach (Core.Models.Attribute attribute in GlobalAttribute.Attributes)
                {
                    await repository.CreateIfNotExistsAsync(attribute);
                }
            }
        }

        public static void InitializeFirebase(this WebApplication app)
        {
            if (File.Exists(Environment.GetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS")))
            {
                FirebaseApp.Create(new AppOptions() { Credential = GoogleCredential.GetApplicationDefault() });
            }
        }
    }
}
