using Microsoft.EntityFrameworkCore.Migrations;

namespace AbangiAPI.Migrations
{
    public partial class AddedRequiredAnnotationForImage : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "ItemImage",
                table: "Items",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "ItemImage",
                table: "Items",
                type: "text",
                nullable: true,
                oldClrType: typeof(string));
        }
    }
}
