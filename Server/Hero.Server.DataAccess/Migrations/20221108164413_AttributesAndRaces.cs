using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class AttributesAndRaces : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DamageBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "DodgeBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "HealthPointsBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "LightDamageBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "LightPointsBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "MeleeDamageBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "MovementSpeedBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "OpticalRangeBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "ParryBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "RangeDamageBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "ResistanceBoost",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "Dodge",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "HealthPoints",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "LightPoints",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "MovementSpeed",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "OpticalRange",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Parry",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Resistance",
                schema: "Hero",
                table: "Characters");

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

            migrationBuilder.AddColumn<Guid>(
                name: "RaceId",
                schema: "Hero",
                table: "Characters",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateTable(
                name: "Attributes",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: true),
                    Name = table.Column<string>(type: "text", nullable: false),
                    IconUrl = table.Column<string>(type: "text", nullable: true),
                    Description = table.Column<string>(type: "text", nullable: true),
                    StepSize = table.Column<double>(type: "double precision", nullable: false),
                    MinValue = table.Column<double>(type: "double precision", nullable: false),
                    MaxValue = table.Column<double>(type: "double precision", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Attributes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Races",
                schema: "Hero",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Races", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AttributeSkills",
                schema: "Hero",
                columns: table => new
                {
                    AttributeId = table.Column<Guid>(type: "uuid", nullable: false),
                    SkillId = table.Column<Guid>(type: "uuid", nullable: false),
                    Value = table.Column<double>(type: "double precision", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AttributeSkills", x => new { x.AttributeId, x.SkillId });
                    table.ForeignKey(
                        name: "FK_AttributeSkills_Attributes_AttributeId",
                        column: x => x.AttributeId,
                        principalSchema: "Hero",
                        principalTable: "Attributes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AttributeSkills_Skills_SkillId",
                        column: x => x.SkillId,
                        principalSchema: "Hero",
                        principalTable: "Skills",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AttributeRaces",
                schema: "Hero",
                columns: table => new
                {
                    AttributeId = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    Value = table.Column<double>(type: "double precision", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AttributeRaces", x => new { x.AttributeId, x.RaceId });
                    table.ForeignKey(
                        name: "FK_AttributeRaces_Attributes_AttributeId",
                        column: x => x.AttributeId,
                        principalSchema: "Hero",
                        principalTable: "Attributes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AttributeRaces_Races_RaceId",
                        column: x => x.RaceId,
                        principalSchema: "Hero",
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Characters_RaceId",
                schema: "Hero",
                table: "Characters",
                column: "RaceId");

            migrationBuilder.CreateIndex(
                name: "IX_AttributeRaces_RaceId",
                schema: "Hero",
                table: "AttributeRaces",
                column: "RaceId");

            migrationBuilder.CreateIndex(
                name: "IX_AttributeSkills_SkillId",
                schema: "Hero",
                table: "AttributeSkills",
                column: "SkillId");

            migrationBuilder.AddForeignKey(
                name: "FK_Characters_Races_RaceId",
                schema: "Hero",
                table: "Characters",
                column: "RaceId",
                principalSchema: "Hero",
                principalTable: "Races",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Characters_Races_RaceId",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropTable(
                name: "AttributeRaces",
                schema: "Hero");

            migrationBuilder.DropTable(
                name: "AttributeSkills",
                schema: "Hero");

            migrationBuilder.DropTable(
                name: "Races",
                schema: "Hero");

            migrationBuilder.DropTable(
                name: "Attributes",
                schema: "Hero");

            migrationBuilder.DropIndex(
                name: "IX_Characters_RaceId",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "RaceId",
                schema: "Hero",
                table: "Characters");

            migrationBuilder.AlterColumn<string>(
                name: "Description",
                schema: "Hero",
                table: "Skills",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AddColumn<double>(
                name: "DamageBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "DodgeBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "HealthPointsBoost",
                schema: "Hero",
                table: "Skills",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<double>(
                name: "LightDamageBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "LightPointsBoost",
                schema: "Hero",
                table: "Skills",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<double>(
                name: "MeleeDamageBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "MovementSpeedBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "OpticalRangeBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "ParryBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "RangeDamageBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "ResistanceBoost",
                schema: "Hero",
                table: "Skills",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Dodge",
                schema: "Hero",
                table: "Characters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "HealthPoints",
                schema: "Hero",
                table: "Characters",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "LightPoints",
                schema: "Hero",
                table: "Characters",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<double>(
                name: "MovementSpeed",
                schema: "Hero",
                table: "Characters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "OpticalRange",
                schema: "Hero",
                table: "Characters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Parry",
                schema: "Hero",
                table: "Characters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Resistance",
                schema: "Hero",
                table: "Characters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);
        }
    }
}
