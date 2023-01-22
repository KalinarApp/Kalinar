using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class UserIdAsStringForFirebase : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.AlterColumn<string>(
                name: "Id",
                schema: "Hero",
                table: "Users",
                type: "text",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AlterColumn<string>(
                name: "OwnerId",
                schema: "Hero",
                table: "Groups",
                type: "text",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AlterColumn<string>(
                name: "UserId",
                schema: "Hero",
                table: "Characters",
                type: "text",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uuid");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<Guid>(
                name: "Id",
                schema: "Hero",
                table: "Users",
                type: "uuid",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<Guid>(
                name: "OwnerId",
                schema: "Hero",
                table: "Groups",
                type: "uuid",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<Guid>(
                name: "UserId",
                schema: "Hero",
                table: "Characters",
                type: "uuid",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

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
    }
}
