using Microsoft.Extensions.Logging;

namespace Hero.Server.Core.Logging
{
    public static partial class ILoggerExtension
    {
        [LoggerMessage((int)EventIds.UnknownErrorOccured, LogLevel.Error, "An unknown error occured.")]
        public static partial void LogUnknownErrorOccured(this ILogger logger, Exception ex);

        [LoggerMessage((int)EventIds.UserAlreadyExists, LogLevel.Error, "A user with this id already exists")]
        public static partial void LogUserAlreadyExists(this ILogger logger);

        [LoggerMessage((int)EventIds.CharacterDoesNotExist, LogLevel.Error, "The character (id: {CharacterId}) you're trying to delete does not exist.")]
        public static partial void LogCharacterDoesNotExist(this ILogger logger, Guid characterId);

        [LoggerMessage((int)EventIds.AbilityDoesNotExist, LogLevel.Error, "The ablility (id: {AbilityId}) you're trying to delete does not exist.")]
        public static partial void LogAbilityDoesNotExist(this ILogger logger, Guid abilityId);

        [LoggerMessage((int)EventIds.NodeDoesNotExist, LogLevel.Error, "The Node (id: {NodeId}) you're trying to delete does not exist.")]
        public static partial void LogNodeDoesNotExist(this ILogger logger, Guid nodeId);

        [LoggerMessage((int)EventIds.SkilltreeDoesNotExist, LogLevel.Error, "The nodeTree (id: {NodeTreeId}) you're trying to delete does not exist.")]
        public static partial void LogSkilltreeDoesNotExist(this ILogger logger, Guid nodeTreeId);

        [LoggerMessage((int)EventIds.SkillDoesNotExist, LogLevel.Error, "The skill (id: {SkillId}) you're trying to delete does not exist.")]
        public static partial void LogSkillDoesNotExist(this ILogger logger, Guid skillId);

        [LoggerMessage((int)EventIds.BlueprintCreated, LogLevel.Information, "The Blueprint (id: {BlueprintId}) was created successfully.")]
        public static partial void LogBlueprintCreated(this ILogger logger, Guid blueprintId);

        [LoggerMessage((int)EventIds.BlueprintCreateFailed, LogLevel.Error, "The Blueprint (id: {BlueprintId}) could not be created.")]
        public static partial void LogBlueprintCreateFailed(this ILogger logger, Guid blueprintId, Exception ex);

        [LoggerMessage((int)EventIds.BlueprintDeleted, LogLevel.Information, "The Blueprint (id: {BlueprintId}) was deleted successfully.")]
        public static partial void LogBlueprintDeleted(this ILogger logger, Guid blueprintId);

        [LoggerMessage((int)EventIds.BlueprintDeleteFailed, LogLevel.Error, "The Blueprint (id: {BlueprintId}) could not be deleted.")]
        public static partial void LogBlueprintDeleteFailed(this ILogger logger, Guid blueprintId, Exception ex);

        [LoggerMessage((int)EventIds.BlueprintUpdated, LogLevel.Information, "The Blueprint (id: {BlueprintId}) was updated successfully.")]
        public static partial void LogBlueprintUpdated(this ILogger logger, Guid blueprintId);

        [LoggerMessage((int)EventIds.BlueprintUpdateFailed, LogLevel.Error, "The Blueprint (id: {BlueprintId}) could not be updated.")]
        public static partial void LogBlueprintUpdateFailed(this ILogger logger, Guid blueprintId, Exception ex);

        [LoggerMessage((int)EventIds.BlueprintDoesNotExist, LogLevel.Error, "The Blueprint (id: {BlueprintId}) does not exist.")]
        public static partial void LogBlueprintNotFound(this ILogger logger, Guid blueprintId);

        [LoggerMessage((int)EventIds.GroupCreated, LogLevel.Information, "The group {GroupName} was created successfully.")]
        public static partial void LogGroupCreatedSuccessfully(this ILogger logger, string groupName);
        [LoggerMessage((int)EventIds.AttributeDoesNotExist, LogLevel.Error, "The attribute (id: {AttributeId}) you're trying to delete does not exist.")]
        public static partial void LogAttributeDoesNotExist(this ILogger logger, Guid attributeId);
        [LoggerMessage((int)EventIds.RaceDoesNotExist, LogLevel.Error, "The race (id: {RaceId}) you're trying to delete does not exist.")]
        public static partial void LogRaceDoesNotExist(this ILogger logger, Guid raceId);
    }
}
