using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class SharingCharacters : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsPublic",
                schema: "Hero",
                table: "Characters",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "ShareAbilities",
                schema: "Hero",
                table: "Characters",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "ShareAttributes",
                schema: "Hero",
                table: "Characters",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "ShareInventory",
                schema: "Hero",
                table: "Characters",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "ShareNotes",
                schema: "Hero",
                table: "Characters",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "ShareSkilltree",
                schema: "Hero",
                table: "Characters",
                type: "boolean",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsPublic",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "ShareAbilities",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "ShareAttributes",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "ShareInventory",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "ShareNotes",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "ShareSkilltree",
                schema: "Hero",
                table: "Characters");
        }
    }
}
