using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class BookPageId : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_StoryBookPage",
                schema: "Hero",
                table: "StoryBookPage");

            migrationBuilder.AlterColumn<DateTime>(
                name: "UpdatedAt",
                schema: "Hero",
                table: "StoryEntries",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now()",
                oldClrType: typeof(bool),
                oldType: "boolean",
                oldDefaultValueSql: "now");

            migrationBuilder.AddColumn<Guid>(
                name: "Id",
                schema: "Hero",
                table: "StoryBookPage",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_StoryBookPage",
                schema: "Hero",
                table: "StoryBookPage",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_StoryBookPage_BookId_PageNumber",
                schema: "Hero",
                table: "StoryBookPage",
                columns: new[] { "BookId", "PageNumber" },
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_StoryBookPage",
                schema: "Hero",
                table: "StoryBookPage");

            migrationBuilder.DropIndex(
                name: "IX_StoryBookPage_BookId_PageNumber",
                schema: "Hero",
                table: "StoryBookPage");

            migrationBuilder.DropColumn(
                name: "Id",
                schema: "Hero",
                table: "StoryBookPage");

            migrationBuilder.AlterColumn<bool>(
                name: "UpdatedAt",
                schema: "Hero",
                table: "StoryEntries",
                type: "boolean",
                nullable: false,
                defaultValueSql: "now",
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone",
                oldDefaultValueSql: "now");

            migrationBuilder.AddPrimaryKey(
                name: "PK_StoryBookPage",
                schema: "Hero",
                table: "StoryBookPage",
                columns: new[] { "BookId", "PageNumber" });
        }
    }
}
