using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class ReaddForeignKeysForUserId : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Users_GroupId",
                schema: "Hero",
                table: "Users",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_Groups_OwnerId",
                schema: "Hero",
                table: "Groups",
                column: "OwnerId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Characters_UserId",
                schema: "Hero",
                table: "Characters",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Characters_Users_UserId",
                schema: "Hero",
                table: "Characters",
                column: "UserId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_Groups_Users_OwnerId",
                schema: "Hero",
                table: "Groups",
                column: "OwnerId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Groups_GroupId",
                schema: "Hero",
                table: "Users",
                column: "GroupId",
                principalSchema: "Hero",
                principalTable: "Groups",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Characters_Users_UserId",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropForeignKey(
                name: "FK_Groups_Users_OwnerId",
                schema: "Hero",
                table: "Groups");

            migrationBuilder.DropForeignKey(
                name: "FK_Users_Groups_GroupId",
                schema: "Hero",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Users_GroupId",
                schema: "Hero",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Groups_OwnerId",
                schema: "Hero",
                table: "Groups");

            migrationBuilder.DropIndex(
                name: "IX_Characters_UserId",
                schema: "Hero",
                table: "Characters");
        }
    }
}
