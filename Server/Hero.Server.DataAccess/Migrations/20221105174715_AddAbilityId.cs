using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AddAbilityId : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Skills_Abilities_AbilityName",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Skills_AbilityName",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Abilities",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "AbilityName",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.AddColumn<Guid>(
                name: "AbilityId",
                schema: "Hero",
                table: "Skills",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "Id",
                schema: "Hero",
                table: "Abilities",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Abilities",
                schema: "Hero",
                table: "Abilities",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Skills_AbilityId",
                schema: "Hero",
                table: "Skills",
                column: "AbilityId");

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Abilities_AbilityId",
                schema: "Hero",
                table: "Skills",
                column: "AbilityId",
                principalSchema: "Hero",
                principalTable: "Abilities",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Skills_Abilities_AbilityId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Skills_AbilityId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Abilities",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "AbilityId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "Id",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.AddColumn<string>(
                name: "AbilityName",
                schema: "Hero",
                table: "Skills",
                type: "character varying(100)",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Abilities",
                schema: "Hero",
                table: "Abilities",
                column: "Name");

            migrationBuilder.CreateIndex(
                name: "IX_Skills_AbilityName",
                schema: "Hero",
                table: "Skills",
                column: "AbilityName");

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Abilities_AbilityName",
                schema: "Hero",
                table: "Skills",
                column: "AbilityName",
                principalSchema: "Hero",
                principalTable: "Abilities",
                principalColumn: "Name",
                onDelete: ReferentialAction.SetNull);
        }
    }
}
