using Microsoft.EntityFrameworkCore.Migrations;

namespace AbangiAPI.Migrations
{
    public partial class transactionHistoriesTablev1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "AmountPaid",
                table: "TransactionHistories",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "ItemCategory",
                table: "TransactionHistories",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ItemLocation",
                table: "TransactionHistories",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ItemPrice",
                table: "TransactionHistories",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AmountPaid",
                table: "TransactionHistories");

            migrationBuilder.DropColumn(
                name: "ItemCategory",
                table: "TransactionHistories");

            migrationBuilder.DropColumn(
                name: "ItemLocation",
                table: "TransactionHistories");

            migrationBuilder.DropColumn(
                name: "ItemPrice",
                table: "TransactionHistories");
        }
    }
}
