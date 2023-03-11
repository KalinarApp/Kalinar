using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class SuggestableRace : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Races",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "CreatedAt",
                schema: "Hero",
                table: "Races",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now()");

            migrationBuilder.AddColumn<string>(
                name: "CreatorId",
                schema: "Hero",
                table: "Races",
                type: "text",
                nullable: false,
                defaultValue: "qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Races",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "RejectedAt",
                schema: "Hero",
                table: "Races",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "RejectionReason",
                schema: "Hero",
                table: "Races",
                type: "character varying(2000)",
                maxLength: 2000,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Races",
                type: "text",
                nullable: false,
                defaultValue: "Approved");

            migrationBuilder.CreateIndex(
                name: "IX_Races_CreatorId",
                schema: "Hero",
                table: "Races",
                column: "CreatorId");

            migrationBuilder.CreateIndex(
                name: "IX_Races_GroupId",
                schema: "Hero",
                table: "Races",
                column: "GroupId");

            migrationBuilder.AddForeignKey(
                name: "FK_Races_Groups_GroupId",
                schema: "Hero",
                table: "Races",
                column: "GroupId",
                principalSchema: "Hero",
                principalTable: "Groups",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Races_Users_CreatorId",
                schema: "Hero",
                table: "Races",
                column: "CreatorId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Races_Groups_GroupId",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropForeignKey(
                name: "FK_Races_Users_CreatorId",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropIndex(
                name: "IX_Races_CreatorId",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropIndex(
                name: "IX_Races_GroupId",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropColumn(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropColumn(
                name: "CreatedAt",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropColumn(
                name: "CreatorId",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropColumn(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropColumn(
                name: "RejectedAt",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropColumn(
                name: "RejectionReason",
                schema: "Hero",
                table: "Races");

            migrationBuilder.DropColumn(
                name: "State",
                schema: "Hero",
                table: "Races");
        }
    }
}
