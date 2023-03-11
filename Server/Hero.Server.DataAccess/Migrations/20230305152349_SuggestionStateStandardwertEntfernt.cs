using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class SuggestionStateStandardwertEntfernt : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Skills",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text",
                oldDefaultValue: "Approved");

            migrationBuilder.AlterColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Attributes",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text",
                oldDefaultValue: "Approved");

            migrationBuilder.AlterColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Abilities",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text",
                oldDefaultValue: "Approved");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Skills",
                type: "text",
                nullable: false,
                defaultValue: "Approved",
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Attributes",
                type: "text",
                nullable: false,
                defaultValue: "Approved",
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Abilities",
                type: "text",
                nullable: false,
                defaultValue: "Approved",
                oldClrType: typeof(string),
                oldType: "text");
        }
    }
}
