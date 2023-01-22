using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class RenameAttributeIconUrlToIconData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "IconUrl",
                schema: "Hero",
                table: "Attributes",
                newName: "IconData");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "IconData",
                schema: "Hero",
                table: "Attributes",
                newName: "IconUrl");
        }
    }
}
