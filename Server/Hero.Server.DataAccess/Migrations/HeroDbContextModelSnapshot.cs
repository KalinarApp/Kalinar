﻿// <auto-generated />
using System;
using System.Collections.Generic;
using Hero.Server.DataAccess.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    [DbContext(typeof(HeroDbContext))]
    partial class HeroDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasDefaultSchema("Hero")
                .HasAnnotation("ProductVersion", "6.0.9")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("Hero.Server.Core.Models.Ability", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset?>("ApprovedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("now()");

                    b.Property<string>("CreatorId")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsPassive")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("LastUpdatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<DateTimeOffset?>("RejectedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("RejectionReason")
                        .HasMaxLength(2000)
                        .HasColumnType("character varying(2000)");

                    b.Property<string>("State")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("Approved");

                    b.HasKey("Id");

                    b.HasIndex("CreatorId");

                    b.HasIndex("GroupId");

                    b.ToTable("Abilities", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Attribute", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset?>("ApprovedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Category")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("now()");

                    b.Property<string>("CreatorId")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconData")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("LastUpdatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<double>("MaxValue")
                        .HasColumnType("double precision");

                    b.Property<double>("MinValue")
                        .HasColumnType("double precision");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("RejectedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("RejectionReason")
                        .HasMaxLength(2000)
                        .HasColumnType("character varying(2000)");

                    b.Property<string>("State")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("Approved");

                    b.Property<double>("StepSize")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

                    b.HasIndex("CreatorId");

                    b.HasIndex("GroupId");

                    b.ToTable("Attributes", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.AttributeRace", b =>
                {
                    b.Property<Guid>("AttributeId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("RaceId")
                        .HasColumnType("uuid");

                    b.Property<double>("Value")
                        .HasColumnType("double precision");

                    b.HasKey("AttributeId", "RaceId");

                    b.HasIndex("RaceId");

                    b.ToTable("AttributeRaces", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.AttributeSkill", b =>
                {
                    b.Property<Guid>("AttributeId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("SkillId")
                        .HasColumnType("uuid");

                    b.Property<double>("Value")
                        .HasColumnType("double precision");

                    b.HasKey("AttributeId", "SkillId");

                    b.HasIndex("SkillId");

                    b.ToTable("AttributeSkills", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Blueprint", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.HasKey("Id");

                    b.ToTable("Blueprints", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.BlueprintNode", b =>
                {
                    b.Property<Guid>("Id")
                        .HasColumnType("uuid");

                    b.Property<string>("Color")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("Cost")
                        .HasColumnType("integer");

                    b.Property<int>("Importance")
                        .HasColumnType("integer");

                    b.Property<bool>("IsEasyReachable")
                        .HasColumnType("boolean");

                    b.Property<Guid?>("ParentId")
                        .HasColumnType("uuid");

                    b.Property<List<Guid>>("Precessors")
                        .IsRequired()
                        .HasColumnType("uuid[]");

                    b.Property<Guid?>("SkillId")
                        .IsRequired()
                        .HasColumnType("uuid");

                    b.Property<List<Guid>>("Successors")
                        .IsRequired()
                        .HasColumnType("uuid[]");

                    b.Property<double>("XPos")
                        .HasColumnType("double precision");

                    b.Property<double>("YPos")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

                    b.HasIndex("ParentId");

                    b.HasIndex("SkillId");

                    b.ToTable("BlueprintNodes", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Character", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int?>("Age")
                        .HasColumnType("integer");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconUrl")
                        .HasColumnType("text");

                    b.Property<string>("Inventory")
                        .HasColumnType("text");

                    b.Property<bool>("IsPublic")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("boolean")
                        .HasDefaultValue(false);

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("Notes")
                        .HasColumnType("text");

                    b.Property<string>("Profession")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<Guid?>("RaceId")
                        .IsRequired()
                        .HasColumnType("uuid");

                    b.Property<string>("Relationship")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("Religion")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<bool?>("ShareAbilities")
                        .HasColumnType("boolean");

                    b.Property<bool?>("ShareAttributes")
                        .HasColumnType("boolean");

                    b.Property<bool?>("ShareInventory")
                        .HasColumnType("boolean");

                    b.Property<bool?>("ShareNotes")
                        .HasColumnType("boolean");

                    b.Property<bool?>("ShareSkilltree")
                        .HasColumnType("boolean");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.HasIndex("RaceId");

                    b.HasIndex("UserId");

                    b.ToTable("Characters", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Group", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<string>("InviteCode")
                        .IsRequired()
                        .HasMaxLength(12)
                        .HasColumnType("character varying(12)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("OwnerId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("OwnerId")
                        .IsUnique();

                    b.ToTable("Groups", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Race", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.HasKey("Id");

                    b.ToTable("Races", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skill", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("AbilityId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset?>("ApprovedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("now()");

                    b.Property<string>("CreatorId")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconUrl")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("LastUpdatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("RejectedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("RejectionReason")
                        .HasMaxLength(2000)
                        .HasColumnType("character varying(2000)");

                    b.Property<string>("State")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("text")
                        .HasDefaultValue("Approved");

                    b.HasKey("Id");

                    b.HasIndex("AbilityId");

                    b.HasIndex("CreatorId");

                    b.HasIndex("GroupId");

                    b.ToTable("Skills", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skilltree", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("CharacterId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsActiveTree")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("boolean")
                        .HasDefaultValue(false);

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<int>("Points")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("CharacterId");

                    b.HasIndex("GroupId");

                    b.ToTable("Skilltrees", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.SkilltreeNode", b =>
                {
                    b.Property<Guid>("Id")
                        .HasColumnType("uuid");

                    b.Property<string>("Color")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("Cost")
                        .HasColumnType("integer");

                    b.Property<int>("Importance")
                        .HasColumnType("integer");

                    b.Property<bool>("IsEasyReachable")
                        .HasColumnType("boolean");

                    b.Property<bool>("IsUnlocked")
                        .HasColumnType("boolean");

                    b.Property<Guid?>("ParentId")
                        .HasColumnType("uuid");

                    b.Property<List<Guid>>("Precessors")
                        .IsRequired()
                        .HasColumnType("uuid[]");

                    b.Property<Guid?>("SkillId")
                        .IsRequired()
                        .HasColumnType("uuid");

                    b.Property<List<Guid>>("Successors")
                        .IsRequired()
                        .HasColumnType("uuid[]");

                    b.Property<DateTime?>("UnlockedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<double>("XPos")
                        .HasColumnType("double precision");

                    b.Property<double>("YPos")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

                    b.HasIndex("ParentId");

                    b.HasIndex("SkillId");

                    b.ToTable("SkilltreeNodes", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Storyline.StoryBookPage", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("BookId")
                        .HasColumnType("uuid");

                    b.Property<string>("Content")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsWritten")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("boolean")
                        .HasDefaultValue(false);

                    b.Property<int>("PageNumber")
                        .HasColumnType("integer");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<DateTime>("UpdatedAt")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("now()");

                    b.HasKey("Id");

                    b.HasIndex("BookId");

                    b.HasIndex("GroupId");

                    b.ToTable("StoryBookPage", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Storyline.StoryEntry", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Date")
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<string>("EntryType")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("ImageUrl")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<bool>("IsUnlocked")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("boolean")
                        .HasDefaultValue(false);

                    b.Property<int>("Order")
                        .HasColumnType("integer");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<DateTime>("UpdatedAt")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("now()");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.ToTable("StoryEntries", "Hero");

                    b.HasDiscriminator<string>("EntryType").HasValue("StoryEntry");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.User", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<Guid?>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.ToTable("Users", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Storyline.StoryBook", b =>
                {
                    b.HasBaseType("Hero.Server.Core.Models.Storyline.StoryEntry");

                    b.HasDiscriminator().HasValue("Book");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Storyline.StoryImage", b =>
                {
                    b.HasBaseType("Hero.Server.Core.Models.Storyline.StoryEntry");

                    b.HasDiscriminator().HasValue("Image");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Ability", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.User", "Creator")
                        .WithMany()
                        .HasForeignKey("CreatorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Group", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Creator");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Attribute", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.User", "Creator")
                        .WithMany()
                        .HasForeignKey("CreatorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Group", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Creator");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.AttributeRace", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Attribute", "Attribute")
                        .WithMany("AttributeRaces")
                        .HasForeignKey("AttributeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Race", "Race")
                        .WithMany("Attributes")
                        .HasForeignKey("RaceId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Attribute");

                    b.Navigation("Race");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.AttributeSkill", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Attribute", "Attribute")
                        .WithMany("AttributeSkills")
                        .HasForeignKey("AttributeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Skill", "Skill")
                        .WithMany("Attributes")
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Attribute");

                    b.Navigation("Skill");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.BlueprintNode", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Blueprint", null)
                        .WithMany("Nodes")
                        .HasForeignKey("ParentId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("Hero.Server.Core.Models.Skill", "Skill")
                        .WithMany()
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("Skill");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Character", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Group", null)
                        .WithMany("Characters")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Race", "Race")
                        .WithMany()
                        .HasForeignKey("RaceId")
                        .OnDelete(DeleteBehavior.SetNull)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.User", null)
                        .WithMany("Characters")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.SetNull)
                        .IsRequired();

                    b.Navigation("Race");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Group", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.User", "Owner")
                        .WithOne("OwnedGroup")
                        .HasForeignKey("Hero.Server.Core.Models.Group", "OwnerId")
                        .OnDelete(DeleteBehavior.SetNull)
                        .IsRequired();

                    b.Navigation("Owner");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skill", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Ability", "Ability")
                        .WithMany()
                        .HasForeignKey("AbilityId")
                        .OnDelete(DeleteBehavior.SetNull);

                    b.HasOne("Hero.Server.Core.Models.User", "Creator")
                        .WithMany()
                        .HasForeignKey("CreatorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Group", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Ability");

                    b.Navigation("Creator");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skilltree", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Character", "Character")
                        .WithMany("Skilltrees")
                        .HasForeignKey("CharacterId")
                        .OnDelete(DeleteBehavior.SetNull);

                    b.HasOne("Hero.Server.Core.Models.Group", null)
                        .WithMany("Skilltrees")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Character");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.SkilltreeNode", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Skilltree", null)
                        .WithMany("Nodes")
                        .HasForeignKey("ParentId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("Hero.Server.Core.Models.Skill", "Skill")
                        .WithMany()
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("Skill");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Storyline.StoryBookPage", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Storyline.StoryBook", null)
                        .WithMany("Pages")
                        .HasForeignKey("BookId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Group", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Storyline.StoryEntry", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Group", null)
                        .WithMany("StoryEntries")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Hero.Server.Core.Models.User", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Group", "Group")
                        .WithMany("Members")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.SetNull);

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Attribute", b =>
                {
                    b.Navigation("AttributeRaces");

                    b.Navigation("AttributeSkills");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Blueprint", b =>
                {
                    b.Navigation("Nodes");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Character", b =>
                {
                    b.Navigation("Skilltrees");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Group", b =>
                {
                    b.Navigation("Characters");

                    b.Navigation("Members");

                    b.Navigation("Skilltrees");

                    b.Navigation("StoryEntries");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Race", b =>
                {
                    b.Navigation("Attributes");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skill", b =>
                {
                    b.Navigation("Attributes");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skilltree", b =>
                {
                    b.Navigation("Nodes");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.User", b =>
                {
                    b.Navigation("Characters");

                    b.Navigation("OwnedGroup");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Storyline.StoryBook", b =>
                {
                    b.Navigation("Pages");
                });
#pragma warning restore 612, 618
        }
    }
}
