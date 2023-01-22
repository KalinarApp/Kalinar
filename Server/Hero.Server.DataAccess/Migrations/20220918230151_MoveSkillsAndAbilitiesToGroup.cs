using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class MoveSkillsAndAbilitiesToGroup : Migration
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

            migrationBuilder.AlterColumn<Guid>(
                name: "UserId",
                schema: "Hero",
                table: "Skills",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AddColumn<Guid>(
                name: "GroupId",
                schema: "Hero",
                table: "Skills",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AlterColumn<Guid>(
                name: "UserId",
                schema: "Hero",
                table: "Abilities",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AddColumn<Guid>(
                name: "GroupId",
                schema: "Hero",
                table: "Abilities",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Skills_GroupId",
                schema: "Hero",
                table: "Skills",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_Abilities_GroupId",
                schema: "Hero",
                table: "Abilities",
                column: "GroupId");

            migrationBuilder.AddForeignKey(
                name: "FK_Abilities_Groups_GroupId",
                schema: "Hero",
                table: "Abilities",
                column: "GroupId",
                principalSchema: "Hero",
                principalTable: "Groups",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Abilities_Users_UserId",
                schema: "Hero",
                table: "Abilities",
                column: "UserId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Groups_GroupId",
                schema: "Hero",
                table: "Skills",
                column: "GroupId",
                principalSchema: "Hero",
                principalTable: "Groups",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Users_UserId",
                schema: "Hero",
                table: "Skills",
                column: "UserId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Abilities_Groups_GroupId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropForeignKey(
                name: "FK_Abilities_Users_UserId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropForeignKey(
                name: "FK_Skills_Groups_GroupId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropForeignKey(
                name: "FK_Skills_Users_UserId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Skills_GroupId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Abilities_GroupId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "GroupId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "GroupId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.AlterColumn<Guid>(
                name: "UserId",
                schema: "Hero",
                table: "Skills",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.AlterColumn<Guid>(
                name: "UserId",
                schema: "Hero",
                table: "Abilities",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Abilities_Users_UserId",
                schema: "Hero",
                table: "Abilities",
                column: "UserId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Users_UserId",
                schema: "Hero",
                table: "Skills",
                column: "UserId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
