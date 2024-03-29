﻿// <auto-generated />
using System;
using System.Collections.Generic;
using Hero.Server.DataAccess.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Hero.Server.DataAccess.Migrations
{
    [DbContext(typeof(HeroDbContext))]
    [Migration("20221114115048_addedPropertiesForCharacters")]
    partial class addedPropertiesForCharacters
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
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

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsPassive")
                        .HasColumnType("boolean");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.ToTable("Abilities", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Attribute", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid?>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconUrl")
                        .HasColumnType("text");

                    b.Property<double>("MaxValue")
                        .HasColumnType("double precision");

                    b.Property<double>("MinValue")
                        .HasColumnType("double precision");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double>("StepSize")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

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

                    b.Property<Guid>("UserId")
                        .HasColumnType("uuid");

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

                    b.Property<Guid>("OwnerId")
                        .HasColumnType("uuid");

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

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconUrl")
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("AbilityId");

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

                    b.Property<double>("XPos")
                        .HasColumnType("double precision");

                    b.Property<double>("YPos")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

                    b.HasIndex("ParentId");

                    b.HasIndex("SkillId");

                    b.ToTable("SkilltreeNodes", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.User", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("GroupId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.ToTable("Users", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Ability", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Group", null)
                        .WithMany("Abilities")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Hero.Server.Core.Models.AttributeRace", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Attribute", "Attribute")
                        .WithMany("AttributeRaces")
                        .HasForeignKey("AttributeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Race", "Race")
                        .WithMany("AttributeRaces")
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
                        .WithMany("AttributeSkills")
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

                    b.HasOne("Hero.Server.Core.Models.Group", null)
                        .WithMany("Skills")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Ability");
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
                    b.Navigation("Abilities");

                    b.Navigation("Characters");

                    b.Navigation("Members");

                    b.Navigation("Skills");

                    b.Navigation("Skilltrees");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Race", b =>
                {
                    b.Navigation("AttributeRaces");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skill", b =>
                {
                    b.Navigation("AttributeSkills");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skilltree", b =>
                {
                    b.Navigation("Nodes");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.User", b =>
                {
                    b.Navigation("Characters");

                    b.Navigation("OwnedGroup")
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}
