using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AllDescriptionsNullable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Nodes",
                schema: "Hero");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                schema: "Hero",
                table: "Skills",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                schema: "Hero",
                table: "Characters",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Description",
                schema: "Hero",
                table: "Skills",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                schema: "Hero",
                table: "Characters",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);

            migrationBuilder.CreateTable(
                name: "Nodes",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Color = table.Column<string>(type: "text", nullable: false),
                    Cost = table.Column<int>(type: "integer", nullable: false),
                    Importance = table.Column<int>(type: "integer", nullable: false),
                    IsEasyReachable = table.Column<bool>(type: "boolean", nullable: false),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false),
                    Precessors = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    SkillId = table.Column<Guid>(type: "uuid", nullable: false),
                    SkilltreeId = table.Column<Guid>(type: "uuid", nullable: true),
                    Successors = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    XPos = table.Column<double>(type: "double precision", nullable: false),
                    YPos = table.Column<double>(type: "double precision", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nodes", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Nodes_SkillId",
                schema: "Hero",
                table: "Nodes",
                column: "SkillId");

            migrationBuilder.CreateIndex(
                name: "IX_Nodes_SkilltreeId",
                schema: "Hero",
                table: "Nodes",
                column: "SkilltreeId");
        }
    }
}
