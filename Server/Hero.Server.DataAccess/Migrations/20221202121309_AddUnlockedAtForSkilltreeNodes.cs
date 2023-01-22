using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AddUnlockedAtForSkilltreeNodes : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "UnlockedAt",
                schema: "Hero",
                table: "SkilltreeNodes",
                type: "timestamp with time zone",
                defaultValueSql: "now()",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UnlockedAt",
                schema: "Hero",
                table: "SkilltreeNodes");
        }
    }
}
