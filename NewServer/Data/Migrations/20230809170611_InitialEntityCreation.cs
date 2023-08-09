using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Kalinar.Data.Migrations
{
    /// <inheritdoc />
    public partial class InitialEntityCreation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "Kalinar");

            migrationBuilder.CreateTable(
                name: "Groups",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    Description = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Groups", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    Username = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "StoryBooks",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Title = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    ImageUrl = table.Column<string>(type: "text", nullable: false),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false),
                    Order = table.Column<int>(type: "integer", nullable: false),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StoryBooks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StoryBooks_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "StoryEvents",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Title = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    Description = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false),
                    Order = table.Column<int>(type: "integer", nullable: false),
                    Date = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StoryEvents", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StoryEvents_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "StoryImages",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Title = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    ImageUrl = table.Column<string>(type: "text", nullable: false),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false),
                    Order = table.Column<int>(type: "integer", nullable: false),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StoryImages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StoryImages_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Abilities",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    IsPassive = table.Column<bool>(type: "boolean", nullable: false),
                    Description = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatorId = table.Column<string>(type: "text", nullable: false),
                    State = table.Column<string>(type: "text", nullable: false),
                    RejectionReason = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    ModifiedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    ApprovedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    RejectedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Abilities", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Abilities_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Abilities_Users_CreatorId",
                        column: x => x.CreatorId,
                        principalSchema: "Kalinar",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Attributes",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    IconData = table.Column<string>(type: "text", nullable: true),
                    Description = table.Column<string>(type: "text", nullable: true),
                    Category = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: true),
                    StepSize = table.Column<double>(type: "double precision", nullable: false),
                    MinValue = table.Column<double>(type: "double precision", nullable: false),
                    MaxValue = table.Column<double>(type: "double precision", nullable: false),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatorId = table.Column<string>(type: "text", nullable: false),
                    State = table.Column<string>(type: "text", nullable: false),
                    RejectionReason = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    ModifiedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    ApprovedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    RejectedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Attributes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Attributes_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Attributes_Users_CreatorId",
                        column: x => x.CreatorId,
                        principalSchema: "Kalinar",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Devices",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    UserId = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Devices", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Devices_Users_UserId",
                        column: x => x.UserId,
                        principalSchema: "Kalinar",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "GroupMembers",
                schema: "Kalinar",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "text", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false),
                    Role = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GroupMembers", x => new { x.UserId, x.GroupId });
                    table.ForeignKey(
                        name: "FK_GroupMembers_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_GroupMembers_Users_UserId",
                        column: x => x.UserId,
                        principalSchema: "Kalinar",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Races",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatorId = table.Column<string>(type: "text", nullable: false),
                    State = table.Column<string>(type: "text", nullable: false),
                    RejectionReason = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    ModifiedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    ApprovedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    RejectedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Races", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Races_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Races_Users_CreatorId",
                        column: x => x.CreatorId,
                        principalSchema: "Kalinar",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "StoryBookPages",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    BookId = table.Column<Guid>(type: "uuid", nullable: false),
                    PageNumber = table.Column<int>(type: "integer", nullable: false),
                    Title = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    Content = table.Column<string>(type: "text", nullable: false),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StoryBookPages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StoryBookPages_StoryBooks_BookId",
                        column: x => x.BookId,
                        principalSchema: "Kalinar",
                        principalTable: "StoryBooks",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AbilityTags",
                schema: "Kalinar",
                columns: table => new
                {
                    Tag = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    AbilityId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AbilityTags", x => new { x.Tag, x.AbilityId });
                    table.ForeignKey(
                        name: "FK_AbilityTags_Abilities_AbilityId",
                        column: x => x.AbilityId,
                        principalSchema: "Kalinar",
                        principalTable: "Abilities",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Skills",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    IconUrl = table.Column<string>(type: "text", nullable: true),
                    Description = table.Column<string>(type: "text", nullable: true),
                    AbilityId = table.Column<Guid>(type: "uuid", nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatorId = table.Column<string>(type: "text", nullable: false),
                    State = table.Column<string>(type: "text", nullable: false),
                    RejectionReason = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    ModifiedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    ApprovedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    RejectedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Skills", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Skills_Abilities_AbilityId",
                        column: x => x.AbilityId,
                        principalSchema: "Kalinar",
                        principalTable: "Abilities",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.SetNull);
                    table.ForeignKey(
                        name: "FK_Skills_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Skills_Users_CreatorId",
                        column: x => x.CreatorId,
                        principalSchema: "Kalinar",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Characters",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    UserId = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    IconUrl = table.Column<string>(type: "text", nullable: true),
                    Age = table.Column<int>(type: "integer", nullable: true),
                    Inventory = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    Religion = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: true),
                    Relationship = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: true),
                    Notes = table.Column<string>(type: "character varying(2048)", maxLength: 2048, nullable: true),
                    Profession = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Characters", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Characters_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Characters_Races_RaceId",
                        column: x => x.RaceId,
                        principalSchema: "Kalinar",
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "RaceAttributes",
                schema: "Kalinar",
                columns: table => new
                {
                    RaceId = table.Column<Guid>(type: "uuid", nullable: false),
                    AttributeId = table.Column<Guid>(type: "uuid", nullable: false),
                    Value = table.Column<double>(type: "double precision", nullable: false),
                    RaceEntityId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RaceAttributes", x => new { x.RaceId, x.AttributeId });
                    table.ForeignKey(
                        name: "FK_RaceAttributes_Attributes_AttributeId",
                        column: x => x.AttributeId,
                        principalSchema: "Kalinar",
                        principalTable: "Attributes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RaceAttributes_Races_RaceEntityId",
                        column: x => x.RaceEntityId,
                        principalSchema: "Kalinar",
                        principalTable: "Races",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RaceAttributes_Races_RaceId",
                        column: x => x.RaceId,
                        principalSchema: "Kalinar",
                        principalTable: "Races",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SkillAttributes",
                schema: "Kalinar",
                columns: table => new
                {
                    SkillId = table.Column<Guid>(type: "uuid", nullable: false),
                    AttributeId = table.Column<Guid>(type: "uuid", nullable: false),
                    Value = table.Column<double>(type: "double precision", nullable: false),
                    SkillEntityId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SkillAttributes", x => new { x.SkillId, x.AttributeId });
                    table.ForeignKey(
                        name: "FK_SkillAttributes_Attributes_AttributeId",
                        column: x => x.AttributeId,
                        principalSchema: "Kalinar",
                        principalTable: "Attributes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SkillAttributes_Skills_SkillEntityId",
                        column: x => x.SkillEntityId,
                        principalSchema: "Kalinar",
                        principalTable: "Skills",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_SkillAttributes_Skills_SkillId",
                        column: x => x.SkillId,
                        principalSchema: "Kalinar",
                        principalTable: "Skills",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Skilltrees",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    IsActive = table.Column<bool>(type: "boolean", nullable: false),
                    Points = table.Column<int>(type: "integer", nullable: false),
                    CharacterId = table.Column<Guid>(type: "uuid", nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    GroupId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Skilltrees", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Skilltrees_Characters_CharacterId",
                        column: x => x.CharacterId,
                        principalSchema: "Kalinar",
                        principalTable: "Characters",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.SetNull);
                    table.ForeignKey(
                        name: "FK_Skilltrees_Groups_GroupId",
                        column: x => x.GroupId,
                        principalSchema: "Kalinar",
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SkilltreeNodes",
                schema: "Kalinar",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    SkilltreeId = table.Column<Guid>(type: "uuid", nullable: false),
                    Importance = table.Column<int>(type: "integer", nullable: false),
                    Cost = table.Column<int>(type: "integer", nullable: false),
                    XPos = table.Column<double>(type: "double precision", nullable: false),
                    YPos = table.Column<double>(type: "double precision", nullable: false),
                    Color = table.Column<string>(type: "text", nullable: false),
                    IsEasyReachable = table.Column<bool>(type: "boolean", nullable: false),
                    IsUnlocked = table.Column<bool>(type: "boolean", nullable: false),
                    SkillId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SkilltreeNodes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SkilltreeNodes_Skills_SkillId",
                        column: x => x.SkillId,
                        principalSchema: "Kalinar",
                        principalTable: "Skills",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_SkilltreeNodes_Skilltrees_SkilltreeId",
                        column: x => x.SkilltreeId,
                        principalSchema: "Kalinar",
                        principalTable: "Skilltrees",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SkilltreeEdges",
                schema: "Kalinar",
                columns: table => new
                {
                    StartId = table.Column<Guid>(type: "uuid", nullable: false),
                    EndId = table.Column<Guid>(type: "uuid", nullable: false),
                    SkilltreeId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SkilltreeEdges", x => new { x.StartId, x.EndId });
                    table.ForeignKey(
                        name: "FK_SkilltreeEdges_SkilltreeNodes_EndId",
                        column: x => x.EndId,
                        principalSchema: "Kalinar",
                        principalTable: "SkilltreeNodes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SkilltreeEdges_SkilltreeNodes_StartId",
                        column: x => x.StartId,
                        principalSchema: "Kalinar",
                        principalTable: "SkilltreeNodes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SkilltreeEdges_Skilltrees_SkilltreeId",
                        column: x => x.SkilltreeId,
                        principalSchema: "Kalinar",
                        principalTable: "Skilltrees",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Abilities_CreatorId",
                schema: "Kalinar",
                table: "Abilities",
                column: "CreatorId");

            migrationBuilder.CreateIndex(
                name: "IX_Abilities_GroupId",
                schema: "Kalinar",
                table: "Abilities",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_AbilityTags_AbilityId",
                schema: "Kalinar",
                table: "AbilityTags",
                column: "AbilityId");

            migrationBuilder.CreateIndex(
                name: "IX_Attributes_CreatorId",
                schema: "Kalinar",
                table: "Attributes",
                column: "CreatorId");

            migrationBuilder.CreateIndex(
                name: "IX_Attributes_GroupId",
                schema: "Kalinar",
                table: "Attributes",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_Characters_GroupId",
                schema: "Kalinar",
                table: "Characters",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_Characters_RaceId",
                schema: "Kalinar",
                table: "Characters",
                column: "RaceId");

            migrationBuilder.CreateIndex(
                name: "IX_Devices_UserId",
                schema: "Kalinar",
                table: "Devices",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_GroupMembers_GroupId",
                schema: "Kalinar",
                table: "GroupMembers",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceAttributes_AttributeId",
                schema: "Kalinar",
                table: "RaceAttributes",
                column: "AttributeId");

            migrationBuilder.CreateIndex(
                name: "IX_RaceAttributes_RaceEntityId",
                schema: "Kalinar",
                table: "RaceAttributes",
                column: "RaceEntityId");

            migrationBuilder.CreateIndex(
                name: "IX_Races_CreatorId",
                schema: "Kalinar",
                table: "Races",
                column: "CreatorId");

            migrationBuilder.CreateIndex(
                name: "IX_Races_GroupId",
                schema: "Kalinar",
                table: "Races",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_SkillAttributes_AttributeId",
                schema: "Kalinar",
                table: "SkillAttributes",
                column: "AttributeId");

            migrationBuilder.CreateIndex(
                name: "IX_SkillAttributes_SkillEntityId",
                schema: "Kalinar",
                table: "SkillAttributes",
                column: "SkillEntityId");

            migrationBuilder.CreateIndex(
                name: "IX_Skills_AbilityId",
                schema: "Kalinar",
                table: "Skills",
                column: "AbilityId");

            migrationBuilder.CreateIndex(
                name: "IX_Skills_CreatorId",
                schema: "Kalinar",
                table: "Skills",
                column: "CreatorId");

            migrationBuilder.CreateIndex(
                name: "IX_Skills_GroupId",
                schema: "Kalinar",
                table: "Skills",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_SkilltreeEdges_EndId",
                schema: "Kalinar",
                table: "SkilltreeEdges",
                column: "EndId");

            migrationBuilder.CreateIndex(
                name: "IX_SkilltreeEdges_SkilltreeId",
                schema: "Kalinar",
                table: "SkilltreeEdges",
                column: "SkilltreeId");

            migrationBuilder.CreateIndex(
                name: "IX_SkilltreeNodes_SkillId",
                schema: "Kalinar",
                table: "SkilltreeNodes",
                column: "SkillId");

            migrationBuilder.CreateIndex(
                name: "IX_SkilltreeNodes_SkilltreeId",
                schema: "Kalinar",
                table: "SkilltreeNodes",
                column: "SkilltreeId");

            migrationBuilder.CreateIndex(
                name: "IX_Skilltrees_CharacterId",
                schema: "Kalinar",
                table: "Skilltrees",
                column: "CharacterId");

            migrationBuilder.CreateIndex(
                name: "IX_Skilltrees_GroupId",
                schema: "Kalinar",
                table: "Skilltrees",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_StoryBookPages_BookId_PageNumber",
                schema: "Kalinar",
                table: "StoryBookPages",
                columns: new[] { "BookId", "PageNumber" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_StoryBooks_GroupId_Order",
                schema: "Kalinar",
                table: "StoryBooks",
                columns: new[] { "GroupId", "Order" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_StoryEvents_GroupId_Order",
                schema: "Kalinar",
                table: "StoryEvents",
                columns: new[] { "GroupId", "Order" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_StoryImages_GroupId_Order",
                schema: "Kalinar",
                table: "StoryImages",
                columns: new[] { "GroupId", "Order" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AbilityTags",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Devices",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "GroupMembers",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "RaceAttributes",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "SkillAttributes",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "SkilltreeEdges",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "StoryBookPages",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "StoryEvents",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "StoryImages",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Attributes",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "SkilltreeNodes",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "StoryBooks",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Skills",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Skilltrees",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Abilities",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Characters",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Races",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Groups",
                schema: "Kalinar");

            migrationBuilder.DropTable(
                name: "Users",
                schema: "Kalinar");
        }
    }
}
