using AutoMapper;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class SkillsController : HeroControllerBase
    {
        private readonly ISkillRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public SkillsController(ISkillRepository repository, IUserRepository userRepository, IMapper mapper, ILogger<SkillsController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet("{id}"), IsGroupAdmin]
        public async Task<IActionResult> GetSkillByIdAsync(Guid id, CancellationToken token)
        {
            await this.userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);
            Skill? skill = await this.repository.GetSkillByIdAsync(id, token);
            if (skill != null)
            {
                SkillResponse value = this.mapper.Map<SkillResponse>(skill);
                return this.Ok(value);
            }

            return this.NotFound();
        }

        [HttpGet, IsGroupAdmin]
        public async Task<IActionResult> GetAllSkillsAsync(CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);
            List<Skill> skills = (await this.repository.GetAllSkillsAsync(token)).ToList();

            return this.Ok(skills.Select(skill => this.mapper.Map<SkillResponse>(skill)).ToList());
        }

        [HttpDelete("{id}"), IsGroupAdmin]
        public async Task<IActionResult> DeleteSkillAsync(Guid id, CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());
            await this.repository.DeleteSkillAsync(id, token);
            return this.Ok();
        }

        [HttpPut("{id}"), IsGroupAdmin]
        public async Task<IActionResult> UpdateSkillAsync(Guid id, [FromBody] SkillRequest request, CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            Skill skill = this.mapper.Map<Skill>(request);
            await this.repository.UpdateSkillAsync(id, skill, token);
            skill = await this.repository.GetSkillByIdAsync(id);

            return this.Ok(this.mapper.Map<SkillResponse>(skill));
        }

        [HttpPost, IsGroupAdmin]
        public async Task<IActionResult> CreateSkillAsync([FromBody] SkillRequest request, CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            Skill skill = this.mapper.Map<Skill>(request);
            await this.repository.CreateSkillAsync(skill, token);
            skill = await this.repository.GetSkillByIdAsync(skill.Id);

            return this.Ok(this.mapper.Map<SkillResponse>(skill));
        }

    }
}
