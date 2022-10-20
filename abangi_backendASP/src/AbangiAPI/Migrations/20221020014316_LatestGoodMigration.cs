using Microsoft.EntityFrameworkCore.Migrations;

namespace AbangiAPI.Migrations
{
    public partial class LatestGoodMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "status",
                table: "Users",
                newName: "Status");

            migrationBuilder.AddColumn<string>(
                name: "UserGovertId",
                table: "Users",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UserGovertId",
                table: "Users");

            migrationBuilder.RenameColumn(
                name: "Status",
                table: "Users",
                newName: "status");
        }
    }
}
