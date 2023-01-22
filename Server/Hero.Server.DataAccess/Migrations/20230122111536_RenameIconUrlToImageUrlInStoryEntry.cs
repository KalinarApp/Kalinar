using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class RenameIconUrlToImageUrlInStoryEntry : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IconUrl",
                schema: "Hero",
                table: "StoryEntries");

            migrationBuilder.AlterColumn<string>(
                name: "ImageUrl",
                schema: "Hero",
                table: "StoryEntries",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "ImageUrl",
                schema: "Hero",
                table: "StoryEntries",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AddColumn<string>(
                name: "IconUrl",
                schema: "Hero",
                table: "StoryEntries",
                type: "text",
                nullable: true);
        }
    }
}
