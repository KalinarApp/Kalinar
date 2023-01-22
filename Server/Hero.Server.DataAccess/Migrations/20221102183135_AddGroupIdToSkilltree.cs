using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AddGroupIdToSkilltree : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "GroupId",
                schema: "Hero",
                table: "Skilltrees",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Skilltrees_GroupId",
                schema: "Hero",
                table: "Skilltrees",
                column: "GroupId");

            migrationBuilder.AddForeignKey(
                name: "FK_Skilltrees_Groups_GroupId",
                schema: "Hero",
                table: "Skilltrees",
                column: "GroupId",
                principalSchema: "Hero",
                principalTable: "Groups",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Skilltrees_Groups_GroupId",
                schema: "Hero",
                table: "Skilltrees");

            migrationBuilder.DropIndex(
                name: "IX_Skilltrees_GroupId",
                schema: "Hero",
                table: "Skilltrees");

            migrationBuilder.DropColumn(
                name: "GroupId",
                schema: "Hero",
                table: "Skilltrees");
        }
    }
}
