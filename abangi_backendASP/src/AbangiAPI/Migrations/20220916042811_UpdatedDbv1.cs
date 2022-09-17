using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

namespace AbangiAPI.Migrations
{
    public partial class UpdatedDbv1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ItemLocation",
                table: "Items",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "RentalMethodId",
                table: "Items",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "RentalMethods",
                columns: table => new
                {
                    RentalMethodId = table.Column<int>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    RentalMethodName = table.Column<string>(nullable: false),
                    RentalMethodDescription = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RentalMethods", x => x.RentalMethodId);
                });

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Items_RentalMethods_RentalMethodId",
                table: "Items");

            migrationBuilder.DropTable(
                name: "RentalMethods");

            migrationBuilder.DropIndex(
                name: "IX_Items_RentalMethodId",
                table: "Items");

            migrationBuilder.DropColumn(
                name: "ItemLocation",
                table: "Items");

            migrationBuilder.DropColumn(
                name: "RentalMethodId",
                table: "Items");
        }
    }
}
