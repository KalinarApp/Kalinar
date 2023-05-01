using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AddMissingPropertiesToItem : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "CreatedAt",
                schema: "Hero",
                table: "Items",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTimeOffset(new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new TimeSpan(0, 0, 0, 0, 0)));

            migrationBuilder.AddColumn<string>(
                name: "CreatorId",
                schema: "Hero",
                table: "Items",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "UpdatedAt",
                schema: "Hero",
                table: "Items",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTimeOffset(new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new TimeSpan(0, 0, 0, 0, 0)));

            migrationBuilder.CreateIndex(
                name: "IX_Items_CreatorId",
                schema: "Hero",
                table: "Items",
                column: "CreatorId");

            migrationBuilder.AddForeignKey(
                name: "FK_Items_Users_CreatorId",
                schema: "Hero",
                table: "Items",
                column: "CreatorId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Items_Users_CreatorId",
                schema: "Hero",
                table: "Items");

            migrationBuilder.DropIndex(
                name: "IX_Items_CreatorId",
                schema: "Hero",
                table: "Items");

            migrationBuilder.DropColumn(
                name: "CreatedAt",
                schema: "Hero",
                table: "Items");

            migrationBuilder.DropColumn(
                name: "CreatorId",
                schema: "Hero",
                table: "Items");

            migrationBuilder.DropColumn(
                name: "UpdatedAt",
                schema: "Hero",
                table: "Items");
        }
    }
}
