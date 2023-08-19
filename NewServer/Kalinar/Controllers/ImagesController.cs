using Contabo.ObjectStorage.S3;

using Kalinar.Authorization;
using Kalinar.Core.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Options;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/upload"), ApiVersion("1.0")]
    // TODO: This controller is only a temporary copied solution from the old backend to allow the frontend to upload images to the server.
    // This should be replaced by a local storage solution, but it has not a high priority and the full backend rewrite is not the right time for this.
    public class ImagesController : ControllerBase
    {
        private readonly S3Options options;

        public ImagesController(IOptions<S3Options> options)
        {
            this.options = options.Value;
        }

        private static string GetExtensionFromBase64(string base64)
        {
            return base64[0] switch
            {
                '/' => "jpg",
                'i' => "png",
                'R' => "gif",
                'U' => "webp",
                _ => throw new ArgumentException("The given filetype is not supported"),
            };
        }

        [HttpPost("image")]
        public async Task<IActionResult> UploadImageAsync([FromBody] ImageRequest request)
        {
            string extension = GetExtensionFromBase64(request.Data);
            string fileWithExtension = Path.ChangeExtension(Path.GetRandomFileName(), extension);

            try
            {
                string tmp = Path.Combine(Path.GetTempPath(), fileWithExtension);
                System.IO.File.WriteAllBytes(tmp, Convert.FromBase64String(request.Data));

                ContaboS3Client client = new(this.options.AccessKey, this.options.SecretKey, this.options.TenantId, ContaboS3RegionEndpoint.EU2);
                ContaboS3File file = await client.UploadFileAsync(tmp, "uploads", this.options.Bucket);

                System.IO.File.Delete(tmp);

                return this.Ok(new { Url = file.FileUrl });
            }
            catch
            {
                throw new ImageUploadFailedException();
            }
        }
    }
}
