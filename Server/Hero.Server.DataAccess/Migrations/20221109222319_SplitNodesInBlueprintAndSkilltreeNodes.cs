using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class SplitNodesInBlueprintAndSkilltreeNodes : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Nodes",
                schema: "Hero");

            migrationBuilder.CreateTable(
                name: "BlueprintNodes",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    SkillId = table.Column<Guid>(type: "uuid", nullable: false),
                    ParentId = table.Column<Guid>(type: "uuid", nullable: true),
                    Importance = table.Column<int>(type: "integer", nullable: false),
                    Cost = table.Column<int>(type: "integer", nullable: false),
                    XPos = table.Column<double>(type: "double precision", nullable: false),
                    YPos = table.Column<double>(type: "double precision", nullable: false),
                    Color = table.Column<string>(type: "text", nullable: false),
                    IsEasyReachable = table.Column<bool>(type: "boolean", nullable: false),
                    Precessors = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    Successors = table.Column<List<Guid>>(type: "uuid[]", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BlueprintNodes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_BlueprintNodes_Blueprints_ParentId",
                        column: x => x.ParentId,
                        principalSchema: "Hero",
                        principalTable: "Blueprints",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_BlueprintNodes_Skills_SkillId",
                        column: x => x.SkillId,
                        principalSchema: "Hero",
                        principalTable: "Skills",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "SkilltreeNodes",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false),
                    SkillId = table.Column<Guid>(type: "uuid", nullable: false),
                    ParentId = table.Column<Guid>(type: "uuid", nullable: true),
                    Importance = table.Column<int>(type: "integer", nullable: false),
                    Cost = table.Column<int>(type: "integer", nullable: false),
                    XPos = table.Column<double>(type: "double precision", nullable: false),
                    YPos = table.Column<double>(type: "double precision", nullable: false),
                    Color = table.Column<string>(type: "text", nullable: false),
                    IsEasyReachable = table.Column<bool>(type: "boolean", nullable: false),
                    Precessors = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    Successors = table.Column<List<Guid>>(type: "uuid[]", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SkilltreeNodes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SkilltreeNodes_Skills_SkillId",
                        column: x => x.SkillId,
                        principalSchema: "Hero",
                        principalTable: "Skills",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_SkilltreeNodes_Skilltrees_ParentId",
                        column: x => x.ParentId,
                        principalSchema: "Hero",
                        principalTable: "Skilltrees",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_BlueprintNodes_ParentId",
                schema: "Hero",
                table: "BlueprintNodes",
                column: "ParentId");

            migrationBuilder.CreateIndex(
                name: "IX_BlueprintNodes_SkillId",
                schema: "Hero",
                table: "BlueprintNodes",
                column: "SkillId");

            migrationBuilder.CreateIndex(
                name: "IX_SkilltreeNodes_ParentId",
                schema: "Hero",
                table: "SkilltreeNodes",
                column: "ParentId");

            migrationBuilder.CreateIndex(
                name: "IX_SkilltreeNodes_SkillId",
                schema: "Hero",
                table: "SkilltreeNodes",
                column: "SkillId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BlueprintNodes",
                schema: "Hero");

            migrationBuilder.DropTable(
                name: "SkilltreeNodes",
                schema: "Hero");

            migrationBuilder.CreateTable(
                name: "Nodes",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    SkillId = table.Column<Guid>(type: "uuid", nullable: false),
                    Color = table.Column<string>(type: "text", nullable: false),
                    Cost = table.Column<int>(type: "integer", nullable: false),
                    Importance = table.Column<int>(type: "integer", nullable: false),
                    IsEasyReachable = table.Column<bool>(type: "boolean", nullable: false),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false),
                    ParentId = table.Column<Guid>(type: "uuid", nullable: true),
                    Precessors = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    Successors = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    XPos = table.Column<double>(type: "double precision", nullable: false),
                    YPos = table.Column<double>(type: "double precision", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nodes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Nodes_Blueprints_ParentId",
                        column: x => x.ParentId,
                        principalSchema: "Hero",
                        principalTable: "Blueprints",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Nodes_Skills_SkillId",
                        column: x => x.SkillId,
                        principalSchema: "Hero",
                        principalTable: "Skills",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Nodes_Skilltrees_ParentId",
                        column: x => x.ParentId,
                        principalSchema: "Hero",
                        principalTable: "Skilltrees",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Nodes_ParentId",
                schema: "Hero",
                table: "Nodes",
                column: "ParentId");

            migrationBuilder.CreateIndex(
                name: "IX_Nodes_SkillId",
                schema: "Hero",
                table: "Nodes",
                column: "SkillId");
        }
    }
}
