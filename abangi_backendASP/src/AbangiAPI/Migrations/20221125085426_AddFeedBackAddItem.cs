using Microsoft.EntityFrameworkCore.Migrations;

namespace AbangiAPI.Migrations
{
    public partial class AddFeedBackAddItem : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ItemId",
                table: "Feedbacks",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Feedbacks_ItemId",
                table: "Feedbacks",
                column: "ItemId");

            migrationBuilder.AddForeignKey(
                name: "FK_Feedbacks_Items_ItemId",
                table: "Feedbacks",
                column: "ItemId",
                principalTable: "Items",
                principalColumn: "ItemId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Feedbacks_Items_ItemId",
                table: "Feedbacks");

            migrationBuilder.DropIndex(
                name: "IX_Feedbacks_ItemId",
                table: "Feedbacks");

            migrationBuilder.DropColumn(
                name: "ItemId",
                table: "Feedbacks");
        }
    }
}
