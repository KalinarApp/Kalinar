﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Kalinar.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddCharacterSkillsView : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"

            CREATE VIEW ""Kalinar"".""CharacterSkills"" AS  
                SELECT DISTINCT st.""CharacterId"",
                   s.""Id"" AS ""SkillId""
                  FROM ""Kalinar"".""SkilltreeNodes"" n
                    JOIN ""Kalinar"".""Skills"" s ON n.""SkillId"" = s.""Id""
                    JOIN ""Kalinar"".""Skilltrees"" st ON n.""SkilltreeId"" = st.""Id""
                 WHERE n.""IsUnlocked"" = true AND st.""CharacterId"" IS NOT NULL;       
            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"DROP VIEW ""Kalinar"".""CharacterSkills""");
        }
    }
}
