using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Kalinar.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddSkilltreePointsView : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"
            CREATE VIEW ""Kalinar"".""SkilltreePoints"" AS 
             SELECT st.""Id"" as ""SkilltreeId"",
                st.""Points"" AS ""Available"",
                COALESCE(sum(n.""Cost""), 0::bigint) AS ""Spent"",
                st.""Points"" - COALESCE(sum(n.""Cost""), 0::bigint) AS ""Remaining""
               FROM ""Kalinar"".""Skilltrees"" st
                 LEFT JOIN ""Kalinar"".""SkilltreeNodes"" n ON st.""Id"" = n.""SkilltreeId"" AND n.""IsUnlocked"" = true
              GROUP BY st.""Id"", st.""Name"", st.""Points"";
            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"DROP VIEW ""Kalinar"".""SkilltreePoints""");
        }
    }
}
