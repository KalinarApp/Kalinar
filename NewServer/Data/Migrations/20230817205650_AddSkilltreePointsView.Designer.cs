﻿// <auto-generated />
using System;
using Kalinar.Data.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Kalinar.Data.Migrations
{
    [DbContext(typeof(Context))]
    [Migration("20230817205650_AddSkilltreePointsView")]
    partial class AddSkilltreePointsView
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasDefaultSchema("Kalinar")
                .HasAnnotation("ProductVersion", "7.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("Kalinar.Core.Entities.AbilityEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset?>("ApprovedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatorId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsPassive")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<DateTimeOffset?>("RejectedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("RejectionReason")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<string>("State")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("CreatorId");

                    b.HasIndex("GroupId");

                    b.ToTable("Abilities", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.AbilityTagEntity", b =>
                {
                    b.Property<string>("Tag")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<Guid>("AbilityId")
                        .HasColumnType("uuid");

                    b.HasKey("Tag", "AbilityId");

                    b.HasIndex("AbilityId");

                    b.ToTable("AbilityTags", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.AttributeEntity", b =>
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
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatorId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconData")
                        .HasColumnType("text");

                    b.Property<bool>("IsDefault")
                        .HasColumnType("boolean");

                    b.Property<double>("MaxValue")
                        .HasColumnType("double precision");

                    b.Property<double>("MinValue")
                        .HasColumnType("double precision");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("RejectedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("RejectionReason")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<string>("State")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double>("StepSize")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

                    b.HasIndex("CreatorId");

                    b.HasIndex("GroupId");

                    b.ToTable("Attributes", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.CharacterEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int?>("Age")
                        .HasColumnType("integer");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconUrl")
                        .HasColumnType("text");

                    b.Property<string>("Inventory")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<string>("Notes")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<string>("Profession")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<Guid>("RaceId")
                        .HasColumnType("uuid");

                    b.Property<string>("Relationship")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<string>("Religion")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.HasIndex("RaceId");

                    b.ToTable("Characters", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.CharacterSkillEntity", b =>
                {
                    b.Property<Guid>("CharacterId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("SkillId")
                        .HasColumnType("uuid");

                    b.HasIndex("SkillId");

                    b.ToTable((string)null);

                    b.ToView("CharacterSkills", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.DeviceEntity", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Devices", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.GroupEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.ToTable("Groups", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.GroupMemberEntity", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("Role")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("UserId", "GroupId");

                    b.HasIndex("GroupId");

                    b.ToTable("GroupMembers", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.RaceAttributeEntity", b =>
                {
                    b.Property<Guid>("RaceId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("AttributeId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("RaceEntityId")
                        .HasColumnType("uuid");

                    b.Property<double>("Value")
                        .HasColumnType("double precision");

                    b.HasKey("RaceId", "AttributeId");

                    b.HasIndex("AttributeId");

                    b.HasIndex("RaceEntityId");

                    b.ToTable("RaceAttributes", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.RaceEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset?>("ApprovedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatorId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<DateTimeOffset?>("RejectedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("RejectionReason")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<string>("State")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("CreatorId");

                    b.HasIndex("GroupId");

                    b.ToTable("Races", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkillAttributeEntity", b =>
                {
                    b.Property<Guid>("SkillId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("AttributeId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("SkillEntityId")
                        .HasColumnType("uuid");

                    b.Property<double>("Value")
                        .HasColumnType("double precision");

                    b.HasKey("SkillId", "AttributeId");

                    b.HasIndex("AttributeId");

                    b.HasIndex("SkillEntityId");

                    b.ToTable("SkillAttributes", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkillEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("AbilityId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset?>("ApprovedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatorId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("IconUrl")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<DateTimeOffset?>("RejectedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("RejectionReason")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<string>("State")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("AbilityId");

                    b.HasIndex("CreatorId");

                    b.HasIndex("GroupId");

                    b.ToTable("Skills", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkilltreeEdgeEntity", b =>
                {
                    b.Property<Guid>("StartId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("EndId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("SkilltreeId")
                        .HasColumnType("uuid");

                    b.HasKey("StartId", "EndId");

                    b.HasIndex("EndId");

                    b.HasIndex("SkilltreeId");

                    b.ToTable("SkilltreeEdges", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkilltreeEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("CharacterId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsActive")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<int>("Points")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("CharacterId");

                    b.HasIndex("GroupId");

                    b.ToTable("Skilltrees", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkilltreeNodeEntity", b =>
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

                    b.Property<Guid>("SkillId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("SkilltreeId")
                        .HasColumnType("uuid");

                    b.Property<double>("XPos")
                        .HasColumnType("double precision");

                    b.Property<double>("YPos")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

                    b.HasIndex("SkillId");

                    b.HasIndex("SkilltreeId");

                    b.ToTable("SkilltreeNodes", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryBookEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("text");

                    b.Property<bool>("IsUnlocked")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.ToTable("StoryBooks", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryBookPageEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("BookId")
                        .HasColumnType("uuid");

                    b.Property<string>("Content")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<bool>("IsUnlocked")
                        .HasColumnType("boolean");

                    b.Property<int>("PageNumber")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasDefaultValue(0);

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.HasKey("Id");

                    b.HasIndex("BookId", "PageNumber")
                        .IsUnique();

                    b.ToTable("StoryBookPages", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryEventEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Date")
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<string>("Description")
                        .HasMaxLength(2048)
                        .HasColumnType("character varying(2048)");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<bool>("IsUnlocked")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int>("Order")
                        .HasColumnType("integer");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.HasKey("Id");

                    b.HasIndex("GroupId", "Order")
                        .IsUnique();

                    b.ToTable("StoryEvents", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryImageEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("GroupId")
                        .HasColumnType("uuid");

                    b.Property<string>("ImageUrl")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<bool>("IsUnlocked")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("ModifiedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.ToTable("StoryImages", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.UserEntity", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.ToTable("Users", "Kalinar");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.AbilityEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.UserEntity", "Creator")
                        .WithMany()
                        .HasForeignKey("CreatorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Creator");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.AbilityTagEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.AbilityEntity", null)
                        .WithMany("Tags")
                        .HasForeignKey("AbilityId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Kalinar.Core.Entities.AttributeEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.UserEntity", "Creator")
                        .WithMany()
                        .HasForeignKey("CreatorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Creator");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.CharacterEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.RaceEntity", "Race")
                        .WithMany()
                        .HasForeignKey("RaceId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("Group");

                    b.Navigation("Race");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.CharacterSkillEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.SkillEntity", "Skill")
                        .WithMany()
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.Navigation("Skill");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.DeviceEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.UserEntity", null)
                        .WithMany("Devices")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Kalinar.Core.Entities.GroupMemberEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany("Members")
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.UserEntity", "User")
                        .WithMany("Groups")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Group");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.RaceAttributeEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.AttributeEntity", "Attribute")
                        .WithMany()
                        .HasForeignKey("AttributeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.RaceEntity", null)
                        .WithMany("Attributes")
                        .HasForeignKey("RaceEntityId");

                    b.HasOne("Kalinar.Core.Entities.RaceEntity", "Race")
                        .WithMany()
                        .HasForeignKey("RaceId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Attribute");

                    b.Navigation("Race");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.RaceEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.UserEntity", "Creator")
                        .WithMany()
                        .HasForeignKey("CreatorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Creator");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkillAttributeEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.AttributeEntity", "Attribute")
                        .WithMany()
                        .HasForeignKey("AttributeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.SkillEntity", null)
                        .WithMany("Attributes")
                        .HasForeignKey("SkillEntityId");

                    b.HasOne("Kalinar.Core.Entities.SkillEntity", "Skill")
                        .WithMany()
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Attribute");

                    b.Navigation("Skill");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkillEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.AbilityEntity", "Ability")
                        .WithMany()
                        .HasForeignKey("AbilityId")
                        .OnDelete(DeleteBehavior.SetNull);

                    b.HasOne("Kalinar.Core.Entities.UserEntity", "Creator")
                        .WithMany()
                        .HasForeignKey("CreatorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Ability");

                    b.Navigation("Creator");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkilltreeEdgeEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.SkilltreeNodeEntity", "End")
                        .WithMany()
                        .HasForeignKey("EndId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.SkilltreeEntity", "Skilltree")
                        .WithMany("Edges")
                        .HasForeignKey("SkilltreeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.SkilltreeNodeEntity", "Start")
                        .WithMany()
                        .HasForeignKey("StartId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("End");

                    b.Navigation("Skilltree");

                    b.Navigation("Start");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkilltreeEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.CharacterEntity", "Character")
                        .WithMany("Skilltrees")
                        .HasForeignKey("CharacterId")
                        .OnDelete(DeleteBehavior.SetNull);

                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Character");

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkilltreeNodeEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.SkillEntity", "Skill")
                        .WithMany()
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("Kalinar.Core.Entities.SkilltreeEntity", "Skilltree")
                        .WithMany("Nodes")
                        .HasForeignKey("SkilltreeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Skill");

                    b.Navigation("Skilltree");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryBookEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryBookPageEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.StoryBookEntity", null)
                        .WithMany("Pages")
                        .HasForeignKey("BookId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryEventEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryImageEntity", b =>
                {
                    b.HasOne("Kalinar.Core.Entities.GroupEntity", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Group");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.AbilityEntity", b =>
                {
                    b.Navigation("Tags");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.CharacterEntity", b =>
                {
                    b.Navigation("Skilltrees");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.GroupEntity", b =>
                {
                    b.Navigation("Members");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.RaceEntity", b =>
                {
                    b.Navigation("Attributes");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkillEntity", b =>
                {
                    b.Navigation("Attributes");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.SkilltreeEntity", b =>
                {
                    b.Navigation("Edges");

                    b.Navigation("Nodes");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.StoryBookEntity", b =>
                {
                    b.Navigation("Pages");
                });

            modelBuilder.Entity("Kalinar.Core.Entities.UserEntity", b =>
                {
                    b.Navigation("Devices");

                    b.Navigation("Groups");
                });
#pragma warning restore 612, 618
        }
    }
}
