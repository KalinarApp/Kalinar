using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AddDescriptionToGroup : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Groups_Users_OwnerId",
                schema: "Hero",
                table: "Groups");

            migrationBuilder.AddColumn<string>(
                name: "Description",
                schema: "Hero",
                table: "Groups",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_Groups_Users_OwnerId",
                schema: "Hero",
                table: "Groups",
                column: "OwnerId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Groups_Users_OwnerId",
                schema: "Hero",
                table: "Groups");

            migrationBuilder.DropColumn(
                name: "Description",
                schema: "Hero",
                table: "Groups");

            migrationBuilder.AddForeignKey(
                name: "FK_Groups_Users_OwnerId",
                schema: "Hero",
                table: "Groups",
                column: "OwnerId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
