using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Kalinar.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddSkilltreeNodeUnlockedAt : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "UnlockedAt",
                schema: "Kalinar",
                table: "SkilltreeNodes",
                type: "timestamp with time zone",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UnlockedAt",
                schema: "Kalinar",
                table: "SkilltreeNodes");
        }
    }
}
