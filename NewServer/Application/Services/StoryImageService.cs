﻿using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class StoryImageService : IStoryImageService
    {
        private readonly IStoryImageRepository imageRepository;
        private readonly IGroupService groupService;

        public StoryImageService(IStoryImageRepository imageRepository, IGroupService groupService)
        {
            this.imageRepository = imageRepository;
            this.groupService = groupService;
        }

        public async Task<IEnumerable<StoryImageEntity>> ListAsync(Guid groupId, bool? unlockedOnly, CancellationToken cancellationToken = default)
        {
            return unlockedOnly.HasValue && unlockedOnly.Value 
                ? await this.imageRepository.ListUnlockedByGroupIdAsync(groupId, cancellationToken) 
                : await this.imageRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<StoryImageEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.imageRepository.FindByIdAsync(id, cancellationToken) ?? throw new StoryImageNotFoundException(id);
        }

        public async Task<StoryImageEntity> CreateAsync(StoryImageCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, cancellationToken: cancellationToken);   

            StoryImageEntity image = new()
            {
                Id = Guid.NewGuid(),
                CreatedAt = DateTime.UtcNow,
                GroupId = request.GroupId,
                Group = group,
                Title = request.Title,
                ImageUrl = request.ImageUrl,
                IsUnlocked = request.IsUnlocked
            };

            return await this.imageRepository.CreateAsync(image, cancellationToken);
        }

        public async Task<StoryImageEntity> UpdateAsync(Guid id, StoryImageUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryImageEntity image = await this.GetByIdAsync(id, cancellationToken);

            image.Title = request.Title;
            image.ImageUrl = request.ImageUrl;
            image.IsUnlocked = request.IsUnlocked;
            image.ModifiedAt = DateTime.UtcNow;

            return await this.imageRepository.UpdateAsync(image, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default) 
        {
            StoryImageEntity image = await this.GetByIdAsync(id, cancellationToken);
            await this.imageRepository.DeleteAsync(image, cancellationToken);
        }
    }
}
