using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;

using Contabo.ObjectStorage.S3;

using Hero.Server.Core.Configuration;
using Hero.Server.Core.Exceptions;
using Hero.Server.Messages.Requests;

using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

using Minio;

namespace Hero.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UploadController : ControllerBase
    {
        private readonly S3Options options;

        public UploadController(IOptions<S3Options> options)
        {
            this.options = options.Value;
        }

        private string GetExtensionFromBase64(string base64)
        {
            string extension = String.Empty;
            switch (base64[0])
            {
                case '/': extension = "jpg"; break;
                case 'i': extension = "png"; break;
                case 'R': extension = "gif"; break;
                case 'U': extension = "webp"; break;
            }
            return extension;
        }

        [HttpPost]
        public async Task<IActionResult> SaveImage([FromBody]UploadRequest request)
        {
            string filename = Path.GetFileNameWithoutExtension(Path.GetRandomFileName());
            string extension = this.GetExtensionFromBase64(request.Data);
            string fileWithExtension = Path.ChangeExtension(Path.GetRandomFileName(), extension);

            if (String.IsNullOrEmpty(extension))
            {
                throw new ArgumentException("The given filetype is not supported");
            }

            try
            {
                string tmp = Path.Combine(Path.GetTempPath(), fileWithExtension);
                System.IO.File.WriteAllBytes(tmp, Convert.FromBase64String(request.Data));

                ContaboS3Client client = new ContaboS3Client(this.options.AccessKey, this.options.SecretKey, this.options.TenantId, ContaboS3RegionEndpoint.EU2);
                ContaboS3File file = await client.UploadFileAsync(tmp, "uploads", this.options.Bucket);

                System.IO.File.Delete(tmp);

                return this.Ok(new { Url = file.FileUrl });
            }
            catch
            {
                throw new HeroException("File upload failed");
            }
        }
    }
}
