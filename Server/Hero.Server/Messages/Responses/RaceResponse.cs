using AutoMapper;
using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class RaceResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public List<AttributeValueResponse> Attributes { get; set; }
    }
}