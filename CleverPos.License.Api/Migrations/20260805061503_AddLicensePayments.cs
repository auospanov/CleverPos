using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CleverPos.License.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddLicensePayments : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "license_payments",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    LicenseId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    PeriodYear = table.Column<int>(type: "int", nullable: false),
                    PeriodMonth = table.Column<int>(type: "int", nullable: false),
                    Amount = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: true),
                    PaidAtUtc = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    Comment = table.Column<string>(type: "varchar(512)", maxLength: 512, nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_license_payments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_license_payments_licenses_LicenseId",
                        column: x => x.LicenseId,
                        principalTable: "licenses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_license_payments_LicenseId_PeriodYear_PeriodMonth",
                table: "license_payments",
                columns: new[] { "LicenseId", "PeriodYear", "PeriodMonth" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "license_payments");
        }
    }
}
