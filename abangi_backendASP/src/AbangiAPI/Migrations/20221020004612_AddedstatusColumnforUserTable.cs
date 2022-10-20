using Microsoft.EntityFrameworkCore.Migrations;

namespace AbangiAPI.Migrations
{
    public partial class AddedstatusColumnforUserTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "status",
                table: "Users",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "status",
                table: "Users");
        }
    }
}
