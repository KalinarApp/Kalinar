using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class RenameNodeTreeToSkilltree : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Nodes_NodeTrees_NodeTreeId",
                schema: "Hero",
                table: "Nodes");

            migrationBuilder.DropTable(
                name: "NodeTrees",
                schema: "Hero");

            migrationBuilder.RenameColumn(
                name: "NodeTreeId",
                schema: "Hero",
                table: "Nodes",
                newName: "SkilltreeId");

            migrationBuilder.RenameIndex(
                name: "IX_Nodes_NodeTreeId",
                schema: "Hero",
                table: "Nodes",
                newName: "IX_Nodes_SkilltreeId");

            migrationBuilder.CreateTable(
                name: "Skilltrees",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", maxLength: 100, nullable: false),
                    CharacterId = table.Column<Guid>(type: "uuid", nullable: true),
                    Name = table.Column<string>(type: "text", nullable: false),
                    IsActiveTree = table.Column<bool>(type: "boolean", nullable: false, defaultValue: false),
                    Points = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Skilltrees", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Skilltrees_Characters_CharacterId",
                        column: x => x.CharacterId,
                        principalSchema: "Hero",
                        principalTable: "Characters",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Skilltrees_CharacterId",
                schema: "Hero",
                table: "Skilltrees",
                column: "CharacterId");

            migrationBuilder.AddForeignKey(
                name: "FK_Nodes_Skilltrees_SkilltreeId",
                schema: "Hero",
                table: "Nodes",
                column: "SkilltreeId",
                principalSchema: "Hero",
                principalTable: "Skilltrees",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Nodes_Skilltrees_SkilltreeId",
                schema: "Hero",
                table: "Nodes");

            migrationBuilder.DropTable(
                name: "Skilltrees",
                schema: "Hero");

            migrationBuilder.RenameColumn(
                name: "SkilltreeId",
                schema: "Hero",
                table: "Nodes",
                newName: "NodeTreeId");

            migrationBuilder.RenameIndex(
                name: "IX_Nodes_SkilltreeId",
                schema: "Hero",
                table: "Nodes",
                newName: "IX_Nodes_NodeTreeId");

            migrationBuilder.CreateTable(
                name: "NodeTrees",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", maxLength: 100, nullable: false),
                    CharacterId = table.Column<Guid>(type: "uuid", nullable: true),
                    IsActiveTree = table.Column<bool>(type: "boolean", nullable: false, defaultValue: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Points = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NodeTrees", x => x.Id);
                    table.ForeignKey(
                        name: "FK_NodeTrees_Characters_CharacterId",
                        column: x => x.CharacterId,
                        principalSchema: "Hero",
                        principalTable: "Characters",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateIndex(
                name: "IX_NodeTrees_CharacterId",
                schema: "Hero",
                table: "NodeTrees",
                column: "CharacterId");

            migrationBuilder.AddForeignKey(
                name: "FK_Nodes_NodeTrees_NodeTreeId",
                schema: "Hero",
                table: "Nodes",
                column: "NodeTreeId",
                principalSchema: "Hero",
                principalTable: "NodeTrees",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
