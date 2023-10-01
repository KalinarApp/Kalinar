using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Kalinar.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddCharacterAttributesView : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"

            CREATE VIEW ""Kalinar"".""CharacterAttributes"" AS  
                 SELECT c.""Id"" AS ""CharacterId"",
                    c.""Name"" AS ""CharacterName"",
                    a.""Id"" AS ""AttributeId"",
                    a.""Name"" AS ""AttributeName"",
                    COALESCE(sum(
                        CASE
                            WHEN n.""IsUnlocked"" THEN sa.""Value""
                            ELSE 0::double precision
                        END), 0::double precision) + COALESCE(ra.""Value"", 0::double precision) AS ""Value""
                   FROM ""Kalinar"".""Characters"" c
                     JOIN ""Kalinar"".""Groups"" g ON c.""GroupId"" = g.""Id""
                     CROSS JOIN ""Kalinar"".""Attributes"" a
                     LEFT JOIN ""Kalinar"".""RaceAttributes"" ra ON c.""RaceId"" = ra.""RaceId"" AND a.""Id"" = ra.""AttributeId""
                     LEFT JOIN ""Kalinar"".""Skilltrees"" st ON c.""Id"" = st.""CharacterId""
                     LEFT JOIN ""Kalinar"".""SkilltreeNodes"" n ON st.""Id"" = n.""SkilltreeId""
                     LEFT JOIN ""Kalinar"".""Skills"" s ON n.""SkillId"" = s.""Id""
                     LEFT JOIN ""Kalinar"".""SkillAttributes"" sa ON s.""Id"" = sa.""SkillId"" AND n.""IsUnlocked"" = true AND a.""Id"" = sa.""AttributeId""
                  WHERE n.""IsUnlocked"" OR ra.""Value"" IS NOT NULL OR sa.""Value"" IS NOT NULL
                  GROUP BY c.""Id"", a.""Id"", ra.""Value""
                 HAVING (COALESCE(sum(
                        CASE
                            WHEN n.""IsUnlocked"" THEN sa.""Value""
                            ELSE 0::double precision
                        END), 0::double precision) + COALESCE(ra.""Value"", 0::double precision)) <> 0::double precision;     
            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"DROP VIEW ""Kalinar"".""CharacterAttributes""");
        }
    }
}
