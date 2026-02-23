using System;
using System.IO;
using System.Windows.Forms;

namespace LicenseGenerator
{
    public partial class MainForm : Form
    {
        private TextBox txtHardwareId;
        private TextBox txtCompany;
        private TextBox txtNif;
        private TextBox txtAddress;
        private TextBox txtEmail;
        private TextBox txtTelephone;
        private TextBox txtReseller;
        private Button btnGenerate;
        private Button btnBrowse;
        private TextBox txtOutputPath;
        private Label lblStatus;

        public MainForm()
        {
            InitializeComponent();
        }

        private void InitializeComponent()
        {
            this.Text = "LogicPOS License Generator";
            this.Size = new System.Drawing.Size(600, 500);
            this.StartPosition = FormStartPosition.CenterScreen;
            this.FormBorderStyle = FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;

            int yPos = 20;
            int labelWidth = 120;
            int textBoxWidth = 420;
            int spacing = 35;

            // HardwareId
            Label lblHardwareId = new Label
            {
                Text = "HardwareId:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblHardwareId);

            txtHardwareId = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(360, 23)
            };
            this.Controls.Add(txtHardwareId);

            Button btnGenerateHardwareId = new Button
            {
                Text = "Generate",
                Location = new System.Drawing.Point(520, yPos),
                Size = new System.Drawing.Size(50, 23),
                Font = new System.Drawing.Font("Microsoft Sans Serif", 8F)
            };
            btnGenerateHardwareId.Click += BtnGenerateHardwareId_Click;
            this.Controls.Add(btnGenerateHardwareId);

            yPos += spacing;

            // Company
            Label lblCompany = new Label
            {
                Text = "Company:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblCompany);

            txtCompany = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23)
            };
            this.Controls.Add(txtCompany);

            yPos += spacing;

            // NIF
            Label lblNif = new Label
            {
                Text = "NIF:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblNif);

            txtNif = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23)
            };
            this.Controls.Add(txtNif);

            yPos += spacing;

            // Address
            Label lblAddress = new Label
            {
                Text = "Address:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblAddress);

            txtAddress = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23)
            };
            this.Controls.Add(txtAddress);

            yPos += spacing;

            // Email
            Label lblEmail = new Label
            {
                Text = "Email:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblEmail);

            txtEmail = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23)
            };
            this.Controls.Add(txtEmail);

            yPos += spacing;

            // Telephone
            Label lblTelephone = new Label
            {
                Text = "Telephone:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblTelephone);

            txtTelephone = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23)
            };
            this.Controls.Add(txtTelephone);

            yPos += spacing;

            // Reseller
            Label lblReseller = new Label
            {
                Text = "Reseller:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblReseller);

            txtReseller = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(textBoxWidth, 23),
                Text = "LogicPulse"
            };
            this.Controls.Add(txtReseller);

            yPos += spacing;

            // Output Path
            Label lblOutputPath = new Label
            {
                Text = "Output Path:",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(labelWidth, 23),
                TextAlign = System.Drawing.ContentAlignment.MiddleLeft
            };
            this.Controls.Add(lblOutputPath);

            txtOutputPath = new TextBox
            {
                Location = new System.Drawing.Point(150, yPos),
                Size = new System.Drawing.Size(350, 23),
                Text = Path.Combine(Environment.CurrentDirectory, "licence.lic")
            };
            this.Controls.Add(txtOutputPath);

            btnBrowse = new Button
            {
                Text = "Browse...",
                Location = new System.Drawing.Point(510, yPos),
                Size = new System.Drawing.Size(60, 23)
            };
            btnBrowse.Click += BtnBrowse_Click;
            this.Controls.Add(btnBrowse);

            yPos += spacing + 10;

            // Status Label
            lblStatus = new Label
            {
                Text = "",
                Location = new System.Drawing.Point(20, yPos),
                Size = new System.Drawing.Size(550, 23),
                ForeColor = System.Drawing.Color.Green
            };
            this.Controls.Add(lblStatus);

            yPos += 30;

            // Generate Button
            btnGenerate = new Button
            {
                Text = "Generate License File",
                Location = new System.Drawing.Point(200, yPos),
                Size = new System.Drawing.Size(200, 35),
                Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold)
            };
            btnGenerate.Click += BtnGenerate_Click;
            this.Controls.Add(btnGenerate);
        }

        private void BtnGenerateHardwareId_Click(object sender, EventArgs e)
        {
            // Генерация GUID как HardwareId
            txtHardwareId.Text = Guid.NewGuid().ToString();
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
                // Валидация обязательных полей
                if (string.IsNullOrWhiteSpace(txtHardwareId.Text))
                {
                    MessageBox.Show("Поле 'HardwareId' обязательно для заполнения!", "Ошибка", 
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtCompany.Text))
                {
                    MessageBox.Show("Поле 'Company' обязательно для заполнения!", "Ошибка", 
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                // Подготовка данных
                var licenseData = new LicenseFileGenerator.LicenseData
                {
                    HardwareId = txtHardwareId.Text.Trim(),
                    Company = txtCompany.Text.Trim(),
                    Nif = txtNif.Text.Trim(),
                    Address = txtAddress.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Telephone = txtTelephone.Text.Trim(),
                    Reseller = string.IsNullOrWhiteSpace(txtReseller.Text) ? "LogicPulse" : txtReseller.Text.Trim()
                };

                // Генерация файла
                string outputPath = txtOutputPath.Text.Trim();
                
                if (string.IsNullOrWhiteSpace(outputPath))
                {
                    outputPath = Path.Combine(Environment.CurrentDirectory, "licence.lic");
                    txtOutputPath.Text = outputPath;
                }

                LicenseFileGenerator.GenerateLicenseFile(outputPath, licenseData);

                // Успех
                lblStatus.Text = $"✓ Файл успешно создан: {outputPath}";
                lblStatus.ForeColor = System.Drawing.Color.Green;

                MessageBox.Show(
                    $"Файл лицензии успешно создан!\n\nПуть: {outputPath}",
                    "Успех",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                lblStatus.Text = $"✗ Ошибка: {ex.Message}";
                lblStatus.ForeColor = System.Drawing.Color.Red;

                MessageBox.Show(
                    $"Ошибка при создании файла лицензии:\n\n{ex.Message}",
                    "Ошибка",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }
    }
}

