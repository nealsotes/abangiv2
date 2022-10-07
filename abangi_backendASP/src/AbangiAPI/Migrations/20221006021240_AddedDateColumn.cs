using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace AbangiAPI.Migrations
{
    public partial class AddedDateColumn : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Items_RentalMethods_RentalMethodId",
                table: "Items");

            migrationBuilder.DropIndex(
                name: "IX_Items_RentalMethodId",
                table: "Items");

            migrationBuilder.AlterColumn<string>(
                name: "RentalMethodDescription",
                table: "RentalMethods",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "DateCreated",
                table: "Items",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "EndDate",
                table: "Items",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "StartDate",
                table: "Items",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DateCreated",
                table: "Items");

            migrationBuilder.DropColumn(
                name: "EndDate",
                table: "Items");

            migrationBuilder.DropColumn(
                name: "StartDate",
                table: "Items");

            migrationBuilder.AlterColumn<string>(
                name: "RentalMethodDescription",
                table: "RentalMethods",
                type: "text",
                nullable: true,
                oldClrType: typeof(string));

            migrationBuilder.CreateIndex(
                name: "IX_Items_RentalMethodId",
                table: "Items",
                column: "RentalMethodId");

            migrationBuilder.AddForeignKey(
                name: "FK_Items_RentalMethods_RentalMethodId",
                table: "Items",
                column: "RentalMethodId",
                principalTable: "RentalMethods",
                principalColumn: "RentalMethodId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
