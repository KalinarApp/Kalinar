using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    public partial class SuggestableFeatures : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Skills",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "CreatedAt",
                schema: "Hero",
                table: "Skills",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now()");

            migrationBuilder.AddColumn<string>(
                name: "CreatorId",
                schema: "Hero",
                table: "Skills",
                type: "text",
                nullable: false,
                defaultValue: "qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Skills",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "RejectedAt",
                schema: "Hero",
                table: "Skills",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "RejectionReason",
                schema: "Hero",
                table: "Skills",
                type: "character varying(2000)",
                maxLength: 2000,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Skills",
                type: "text",
                nullable: false,
                defaultValue: "Approved");

            migrationBuilder.AlterColumn<Guid>(
                name: "GroupId",
                schema: "Hero",
                table: "Attributes",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Attributes",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "CreatedAt",
                schema: "Hero",
                table: "Attributes",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now()");

            migrationBuilder.AddColumn<string>(
                name: "CreatorId",
                schema: "Hero",
                table: "Attributes",
                type: "text",
                nullable: false,
                defaultValue: "qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Attributes",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "RejectedAt",
                schema: "Hero",
                table: "Attributes",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "RejectionReason",
                schema: "Hero",
                table: "Attributes",
                type: "character varying(2000)",
                maxLength: 2000,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Attributes",
                type: "text",
                nullable: false,
                defaultValue: "Approved");

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Abilities",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "CreatedAt",
                schema: "Hero",
                table: "Abilities",
                type: "timestamp with time zone",
                nullable: false,
                defaultValueSql: "now()");

            migrationBuilder.AddColumn<string>(
                name: "CreatorId",
                schema: "Hero",
                table: "Abilities",
                type: "text",
                nullable: false,
                defaultValue: "qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Abilities",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "RejectedAt",
                schema: "Hero",
                table: "Abilities",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "RejectionReason",
                schema: "Hero",
                table: "Abilities",
                type: "character varying(2000)",
                maxLength: 2000,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "State",
                schema: "Hero",
                table: "Abilities",
                type: "text",
                nullable: false,
                defaultValue: "Approved");

            migrationBuilder.CreateIndex(
                name: "IX_Skills_CreatorId",
                schema: "Hero",
                table: "Skills",
                column: "CreatorId");

            migrationBuilder.CreateIndex(
                name: "IX_Attributes_CreatorId",
                schema: "Hero",
                table: "Attributes",
                column: "CreatorId");

            migrationBuilder.CreateIndex(
                name: "IX_Attributes_GroupId",
                schema: "Hero",
                table: "Attributes",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_Abilities_CreatorId",
                schema: "Hero",
                table: "Abilities",
                column: "CreatorId");

            migrationBuilder.AddForeignKey(
                name: "FK_Abilities_Users_CreatorId",
                schema: "Hero",
                table: "Abilities",
                column: "CreatorId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Attributes_Users_CreatorId",
                schema: "Hero",
                table: "Attributes",
                column: "CreatorId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Users_CreatorId",
                schema: "Hero",
                table: "Skills",
                column: "CreatorId",
                principalSchema: "Hero",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Abilities_Users_CreatorId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropForeignKey(
                name: "FK_Attributes_Users_CreatorId",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropForeignKey(
                name: "FK_Skills_Users_CreatorId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Skills_CreatorId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropIndex(
                name: "IX_Attributes_CreatorId",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropIndex(
                name: "IX_Attributes_GroupId",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropIndex(
                name: "IX_Abilities_CreatorId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "CreatedAt",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "CreatorId",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "RejectedAt",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "RejectionReason",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "State",
                schema: "Hero",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropColumn(
                name: "CreatedAt",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropColumn(
                name: "CreatorId",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropColumn(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropColumn(
                name: "RejectedAt",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropColumn(
                name: "RejectionReason",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropColumn(
                name: "State",
                schema: "Hero",
                table: "Attributes");

            migrationBuilder.DropColumn(
                name: "ApprovedAt",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "CreatedAt",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "CreatorId",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "LastUpdatedAt",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "RejectedAt",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "RejectionReason",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.DropColumn(
                name: "State",
                schema: "Hero",
                table: "Abilities");

            migrationBuilder.AlterColumn<Guid>(
                name: "GroupId",
                schema: "Hero",
                table: "Attributes",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");
        }
    }
}
