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
    [Migration("20220918230151_MoveSkillsAndAbilitiesToGroup")]
    partial class MoveSkillsAndAbilitiesToGroup
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
                    b.Property<string>("Name")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsPassive")
                        .HasColumnType("boolean");

                    b.Property<Guid?>("UserId")
                        .HasColumnType("uuid");

                    b.HasKey("Name");

                    b.HasIndex("GroupId");

                    b.HasIndex("UserId");

                    b.ToTable("Abilities", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Character", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double>("Dodge")
                        .HasColumnType("double precision");

                    b.Property<int>("HealthPoints")
                        .HasColumnType("integer");

                    b.Property<int>("LightPoints")
                        .HasColumnType("integer");

                    b.Property<double>("MovementSpeed")
                        .HasColumnType("double precision");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<double>("OpticalRange")
                        .HasColumnType("double precision");

                    b.Property<double>("Parry")
                        .HasColumnType("double precision");

                    b.Property<double>("Resistance")
                        .HasColumnType("double precision");

                    b.Property<Guid?>("UserId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Characters", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Group", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

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

            modelBuilder.Entity("Hero.Server.Core.Models.Node", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
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

                    b.Property<Guid?>("NodeTreeId")
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

                    b.HasIndex("NodeTreeId");

                    b.HasIndex("SkillId");

                    b.ToTable("Nodes", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.NodeTree", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasMaxLength(100)
                        .HasColumnType("uuid");

                    b.Property<Guid?>("CharacterId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsActiveTree")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("boolean")
                        .HasDefaultValue(false);

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("Points")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("CharacterId");

                    b.ToTable("NodeTrees", "Hero");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skill", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("AbilityName")
                        .IsRequired()
                        .HasColumnType("character varying(100)");

                    b.Property<double>("DamageBoost")
                        .HasColumnType("double precision");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double>("DodgeBoost")
                        .HasColumnType("double precision");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<int>("HealthPointsBoost")
                        .HasColumnType("integer");

                    b.Property<string>("IconUrl")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double>("LightDamageBoost")
                        .HasColumnType("double precision");

                    b.Property<int>("LightPointsBoost")
                        .HasColumnType("integer");

                    b.Property<double>("MeleeDamageBoost")
                        .HasColumnType("double precision");

                    b.Property<double>("MovementSpeedBoost")
                        .HasColumnType("double precision");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double>("OpticalRangeBoost")
                        .HasColumnType("double precision");

                    b.Property<double>("ParryBoost")
                        .HasColumnType("double precision");

                    b.Property<double>("RangeDamageBoost")
                        .HasColumnType("double precision");

                    b.Property<double>("ResistanceBoost")
                        .HasColumnType("double precision");

                    b.Property<Guid?>("UserId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("AbilityName");

                    b.HasIndex("GroupId");

                    b.HasIndex("UserId");

                    b.ToTable("Skills", "Hero");
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

                    b.HasOne("Hero.Server.Core.Models.User", null)
                        .WithMany("Abilities")
                        .HasForeignKey("UserId");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Character", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.User", null)
                        .WithMany("Characters")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.SetNull);
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Group", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.User", "Owner")
                        .WithOne("OwnedGroup")
                        .HasForeignKey("Hero.Server.Core.Models.Group", "OwnerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Owner");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Node", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.NodeTree", null)
                        .WithMany("AllNodes")
                        .HasForeignKey("NodeTreeId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("Hero.Server.Core.Models.Skill", "Skill")
                        .WithMany()
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("Skill");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.NodeTree", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Character", null)
                        .WithMany("NodeTrees")
                        .HasForeignKey("CharacterId")
                        .OnDelete(DeleteBehavior.SetNull);
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Skill", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Ability", "Ability")
                        .WithMany()
                        .HasForeignKey("AbilityName")
                        .OnDelete(DeleteBehavior.SetNull)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.Group", null)
                        .WithMany("Skills")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Hero.Server.Core.Models.User", null)
                        .WithMany("Skills")
                        .HasForeignKey("UserId");

                    b.Navigation("Ability");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.User", b =>
                {
                    b.HasOne("Hero.Server.Core.Models.Group", null)
                        .WithMany("Users")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.SetNull);
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Character", b =>
                {
                    b.Navigation("NodeTrees");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.Group", b =>
                {
                    b.Navigation("Abilities");

                    b.Navigation("Skills");

                    b.Navigation("Users");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.NodeTree", b =>
                {
                    b.Navigation("AllNodes");
                });

            modelBuilder.Entity("Hero.Server.Core.Models.User", b =>
                {
                    b.Navigation("Abilities");

                    b.Navigation("Characters");

                    b.Navigation("OwnedGroup")
                        .IsRequired();

                    b.Navigation("Skills");
                });
#pragma warning restore 612, 618
        }
    }
}
