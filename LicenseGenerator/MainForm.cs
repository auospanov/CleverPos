using System;
using System.IO;
using System.Windows.Forms;
using CleverPos.License.Core;

namespace LicenseGenerator
{
    public partial class MainForm : Form
    {
        private TextBox txtCompany;
        private TextBox txtBin;
        private TextBox txtOutputPath;
        private Label lblStatus;
        private Label lblGeneratedKey;

        public MainForm()
        {
            InitializeComponent();
        }

        private void InitializeComponent()
        {
            this.Text = "CleverPos — генератор лицензии";
            this.Size = new System.Drawing.Size(620, 320);
            this.StartPosition = FormStartPosition.CenterScreen;
            this.FormBorderStyle = FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;

            int yPos = 20;
            int labelWidth = 140;
            int textBoxWidth = 420;
            int spacing = 40;

            Label lblHint = new Label
            {
                Text = "Нужны только компания и БИН. Ключ и привязка ПК появятся автоматически.",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(560, 36),
                ForeColor = System.Drawing.Color.DimGray
            };
            this.Controls.Add(lblHint);
            yPos += 44;

            Label lblCompany = new Label
            {
                Text = "Компания *:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblCompany);

            txtCompany = new TextBox
            {
                Location = new System.Drawing.Point(170, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23)
            };
            this.Controls.Add(txtCompany);
            yPos += spacing;

            Label lblBin = new Label
            {
                Text = "БИН *:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblBin);

            txtBin = new TextBox
            {
                Location = new System.Drawing.Point(170, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23),
                MaxLength = 12
            };
            this.Controls.Add(txtBin);
            yPos += spacing;

            Label lblOutputPath = new Label
            {
                Text = "Файл:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblOutputPath);

            txtOutputPath = new TextBox
            {
                Location = new System.Drawing.Point(170, yPos),
                Size = new System.Drawing.Size(350, 23),
                Text = Path.Combine(Environment.CurrentDirectory, "licence.lic")
            };
            this.Controls.Add(txtOutputPath);

            Button btnBrowse = new Button
            {
                Text = "Обзор…",
                Location = new System.Drawing.Point(530, yPos),
                Size = new System.Drawing.Size(60, 23)
            };
            btnBrowse.Click += BtnBrowse_Click;
            this.Controls.Add(btnBrowse);
            yPos += spacing;

            lblGeneratedKey = new Label
            {
                Text = "",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(560, 23),
                Font = new System.Drawing.Font("Consolas", 9F)
            };
            this.Controls.Add(lblGeneratedKey);
            yPos += 28;

            lblStatus = new Label
            {
                Text = "",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(560, 23)
            };
            this.Controls.Add(lblStatus);
            yPos += 36;

            Button btnGenerate = new Button
            {
                Text = "Создать licence.lic",
                Location = new System.Drawing.Point(200, yPos),
                Size = new System.Drawing.Size(200, 36),
                Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold)
            };
            btnGenerate.Click += BtnGenerate_Click;
            this.Controls.Add(btnGenerate);
        }

        private void BtnBrowse_Click(object sender, EventArgs e)
        {
            using (SaveFileDialog saveDialog = new SaveFileDialog())
            {
                saveDialog.Filter = "License Files (*.lic)|*.lic|All Files (*.*)|*.*";
                saveDialog.FileName = "licence.lic";
                saveDialog.DefaultExt = "lic";
                if (saveDialog.ShowDialog() == DialogResult.OK)
                {
                    txtOutputPath.Text = saveDialog.FileName;
                }
            }
        }

        private void BtnGenerate_Click(object sender, EventArgs e)
        {
            try
            {
                string company = (txtCompany.Text ?? string.Empty).Trim();
                string bin = (txtBin.Text ?? string.Empty).Trim();

                if (string.IsNullOrWhiteSpace(company))
                {
                    MessageBox.Show("Укажите название компании.", "Ошибка",
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                if (!IsValidKazakhstanBin(bin))
                {
                    MessageBox.Show("БИН должен состоять из 12 цифр.", "Ошибка",
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                string licenseKey = Guid.NewGuid().ToString("N").ToUpperInvariant();
                var licenseData = new LicenseFileGenerator.LicenseData
                {
                    LicenseKey = licenseKey,
                    HardwareId = LicensePayload.UnboundHardwareId,
                    Company = company,
                    Nif = bin,
                    Address = string.Empty,
                    Email = string.Empty,
                    Telephone = string.Empty,
                    Reseller = "CleverPos"
                };

                string outputPath = (txtOutputPath.Text ?? string.Empty).Trim();
                if (string.IsNullOrWhiteSpace(outputPath))
                {
                    outputPath = Path.Combine(Environment.CurrentDirectory, "licence.lic");
                    txtOutputPath.Text = outputPath;
                }

                LicenseFileGenerator.GenerateLicenseFile(outputPath, licenseData);

                lblGeneratedKey.Text = "LicenseKey: " + licenseKey;
                lblStatus.Text = "Файл создан: " + outputPath;
                lblStatus.ForeColor = System.Drawing.Color.Green;

                MessageBox.Show(
                    "licence.lic создан.\n\nКомпания: " + company +
                    "\nБИН: " + bin +
                    "\nКлюч (в админку / облако): " + licenseKey +
                    "\n\nHardwareId пока не привязан — касса привяжет ПК при первом запуске.\n\nПуть:\n" + outputPath,
                    "Готово",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Ошибка: " + ex.Message;
                lblStatus.ForeColor = System.Drawing.Color.Red;
                MessageBox.Show("Ошибка:\n\n" + ex.Message, "Ошибка",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private static bool IsValidKazakhstanBin(string bin)
        {
            if (string.IsNullOrWhiteSpace(bin) || bin.Length != 12)
            {
                return false;
            }

            for (int i = 0; i < bin.Length; i++)
            {
                if (!char.IsDigit(bin[i]))
                {
                    return false;
                }
            }

            return true;
        }
    }
}
