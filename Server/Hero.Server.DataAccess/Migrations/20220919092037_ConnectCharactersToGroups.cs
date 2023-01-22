using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class ConnectCharactersToGroups : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Abilities_Users_UserId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropForeignKey(
                name: "FK_Skills_Users_UserId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Skills_UserId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Abilities_UserId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "UserId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "UserId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.AddColumn<Guid>(
                name: "GroupId",
                schema: "Hero",
                table: "Characters",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Characters_GroupId",
                schema: "Hero",
                table: "Characters",
                column: "GroupId");

            migrationBuilder.AddForeignKey(
                name: "FK_Characters_Groups_GroupId",
                schema: "Hero",
                table: "Characters",
                column: "GroupId",
                principalSchema: "Hero",
                principalTable: "Groups",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Characters_Groups_GroupId",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropIndex(
                name: "IX_Characters_GroupId",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "GroupId",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.AddColumn<Guid>(
                name: "UserId",
                schema: "Hero",
                table: "Skills",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId",
                schema: "Hero",
                table: "Abilities",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Skills_UserId",
                schema: "Hero",
                table: "Skills",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Abilities_UserId",
                schema: "Hero",
                table: "Abilities",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Abilities_Users_UserId",
                schema: "Hero",
                table: "Abilities",
                column: "UserId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Users_UserId",
                schema: "Hero",
                table: "Skills",
                column: "UserId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id");
        }
    }
}
