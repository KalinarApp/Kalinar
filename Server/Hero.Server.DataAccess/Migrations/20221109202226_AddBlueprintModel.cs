using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AddBlueprintModel : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Nodes_Skilltrees_SkilltreeId",
                schema: "Hero",
                table: "Nodes");

            migrationBuilder.RenameColumn(
                name: "SkilltreeId",
                schema: "Hero",
                table: "Nodes",
                newName: "ParentId");

            migrationBuilder.RenameIndex(
                name: "IX_Nodes_SkilltreeId",
                schema: "Hero",
                table: "Nodes",
                newName: "IX_Nodes_ParentId");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                schema: "Hero",
                table: "Skilltrees",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.CreateTable(
                name: "Blueprints",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Blueprints", x => x.Id);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Nodes_Blueprints_ParentId",
                schema: "Hero",
                table: "Nodes",
                column: "ParentId",
                principalSchema: "Hero",
                principalTable: "Blueprints",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Nodes_Skilltrees_ParentId",
                schema: "Hero",
                table: "Nodes",
                column: "ParentId",
                principalSchema: "Hero",
                principalTable: "Skilltrees",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Nodes_Blueprints_ParentId",
                schema: "Hero",
                table: "Nodes");

            migrationBuilder.DropForeignKey(
                name: "FK_Nodes_Skilltrees_ParentId",
                schema: "Hero",
                table: "Nodes");

            migrationBuilder.DropTable(
                name: "Blueprints",
                schema: "Hero");

            migrationBuilder.RenameColumn(
                name: "ParentId",
                schema: "Hero",
                table: "Nodes",
                newName: "SkilltreeId");

            migrationBuilder.RenameIndex(
                name: "IX_Nodes_ParentId",
                schema: "Hero",
                table: "Nodes",
                newName: "IX_Nodes_SkilltreeId");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                schema: "Hero",
                table: "Skilltrees",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "character varying(100)",
                oldMaxLength: 100);

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
    }
}
