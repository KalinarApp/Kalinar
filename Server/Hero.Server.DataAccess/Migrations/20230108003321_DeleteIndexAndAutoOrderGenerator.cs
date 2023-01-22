using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class DeleteIndexAndAutoOrderGenerator : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_StoryBookPage_BookId_PageNumber",
                schema: "Hero",
                table: "StoryBookPage");

            migrationBuilder.AlterColumn<DateTime>(
                name: "UpdatedAt",
                schema: "Hero",
                table: "StoryEntries",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now()",
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone",
                oldDefaultValueSql: "now");

            migrationBuilder.AlterColumn<int>(
                name: "Order",
                schema: "Hero",
                table: "StoryEntries",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .OldAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AlterColumn<DateTime>(
                name: "UpdatedAt",
                schema: "Hero",
                table: "StoryBookPage",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now()",
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone",
                oldDefaultValueSql: "now");

            migrationBuilder.AlterColumn<int>(
                name: "PageNumber",
                schema: "Hero",
                table: "StoryBookPage",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .OldAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.CreateIndex(
                name: "IX_StoryBookPage_BookId",
                schema: "Hero",
                table: "StoryBookPage",
                column: "BookId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_StoryBookPage_BookId",
                schema: "Hero",
                table: "StoryBookPage");

            migrationBuilder.AlterColumn<DateTime>(
                name: "UpdatedAt",
                schema: "Hero",
                table: "StoryEntries",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now",
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone",
                oldDefaultValueSql: "now()");

            migrationBuilder.AlterColumn<int>(
                name: "Order",
                schema: "Hero",
                table: "StoryEntries",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AlterColumn<DateTime>(
                name: "UpdatedAt",
                schema: "Hero",
                table: "StoryBookPage",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now",
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone",
                oldDefaultValueSql: "now()");

            migrationBuilder.AlterColumn<int>(
                name: "PageNumber",
                schema: "Hero",
                table: "StoryBookPage",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.CreateIndex(
                name: "IX_StoryBookPage_BookId_PageNumber",
                schema: "Hero",
                table: "StoryBookPage",
                columns: new[] { "BookId", "PageNumber" },
                unique: true);
        }
    }
}
