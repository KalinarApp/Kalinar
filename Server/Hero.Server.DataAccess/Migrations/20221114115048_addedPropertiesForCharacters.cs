using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class addedPropertiesForCharacters : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Age",
                schema: "Hero",
                table: "Characters",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "IconUrl",
                schema: "Hero",
                table: "Characters",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Inventory",
                schema: "Hero",
                table: "Characters",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Notes",
                schema: "Hero",
                table: "Characters",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Profession",
                schema: "Hero",
                table: "Characters",
                type: "character varying(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Relationship",
                schema: "Hero",
                table: "Characters",
                type: "character varying(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Religion",
                schema: "Hero",
                table: "Characters",
                type: "character varying(100)",
                maxLength: 100,
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Age",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "IconUrl",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Inventory",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Notes",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Profession",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Relationship",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Religion",
                schema: "Hero",
                table: "Characters");
        }
    }
}
