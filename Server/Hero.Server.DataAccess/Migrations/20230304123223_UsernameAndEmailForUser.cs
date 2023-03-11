using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class UsernameAndEmailForUser : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Email",
                schema: "Hero",
                table: "Users",
                type: "character varying(256)",
                maxLength: 256,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Username",
                schema: "Hero",
                table: "Users",
                type: "character varying(256)",
                maxLength: 256,
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Email",
                schema: "Hero",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "Username",
                schema: "Hero",
                table: "Users");
        }
    }
}
