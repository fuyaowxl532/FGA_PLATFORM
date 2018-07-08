namespace FGA_WinForm
{
    partial class BarcodeHelper_CA
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.prtbtn = new System.Windows.Forms.Button();
            this.cpBox = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.sfcBox = new System.Windows.Forms.ComboBox();
            this.rtbtn = new System.Windows.Forms.Button();
            this.tnBox = new System.Windows.Forms.ComboBox();
            this.cprBox = new System.Windows.Forms.TextBox();
            this.PrintNum = new System.Windows.Forms.Label();
            this.cbPrintNum = new System.Windows.Forms.ComboBox();
            this.pwdtb = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // prtbtn
            // 
            this.prtbtn.BackColor = System.Drawing.Color.Blue;
            this.prtbtn.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.prtbtn.Location = new System.Drawing.Point(303, 108);
            this.prtbtn.Name = "prtbtn";
            this.prtbtn.Size = new System.Drawing.Size(119, 66);
            this.prtbtn.TabIndex = 0;
            this.prtbtn.Text = "prtLabel";
            this.prtbtn.UseVisualStyleBackColor = false;
            this.prtbtn.Click += new System.EventHandler(this.button1_Click);
            // 
            // cpBox
            // 
            this.cpBox.Enabled = false;
            this.cpBox.Location = new System.Drawing.Point(146, 135);
            this.cpBox.Name = "cpBox";
            this.cpBox.Size = new System.Drawing.Size(121, 20);
            this.cpBox.TabIndex = 2;
            this.cpBox.Text = "2929403";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label1.Location = new System.Drawing.Point(25, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(54, 12);
            this.label1.TabIndex = 5;
            this.label1.Text = "Tool_NO";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label2.Location = new System.Drawing.Point(25, 81);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(117, 12);
            this.label2.TabIndex = 6;
            this.label2.Text = "Shift_First_Char";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label3.Location = new System.Drawing.Point(25, 139);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(96, 12);
            this.label3.TabIndex = 7;
            this.label3.Text = "Customer_Part";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label4.Location = new System.Drawing.Point(25, 193);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(61, 12);
            this.label4.TabIndex = 8;
            this.label4.Text = "Revision";
            // 
            // sfcBox
            // 
            this.sfcBox.AllowDrop = true;
            this.sfcBox.FormattingEnabled = true;
            this.sfcBox.Items.AddRange(new object[] {
            "1",
            "2",
            "3"});
            this.sfcBox.Location = new System.Drawing.Point(146, 78);
            this.sfcBox.Name = "sfcBox";
            this.sfcBox.Size = new System.Drawing.Size(121, 21);
            this.sfcBox.TabIndex = 9;
            // 
            // rtbtn
            // 
            this.rtbtn.BackColor = System.Drawing.Color.Aqua;
            this.rtbtn.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.rtbtn.Location = new System.Drawing.Point(27, 235);
            this.rtbtn.Name = "rtbtn";
            this.rtbtn.Size = new System.Drawing.Size(39, 27);
            this.rtbtn.TabIndex = 10;
            this.rtbtn.Text = "reset";
            this.rtbtn.UseVisualStyleBackColor = false;
            this.rtbtn.Visible = false;
            this.rtbtn.Click += new System.EventHandler(this.button2_Click);
            // 
            // tnBox
            // 
            this.tnBox.Enabled = false;
            this.tnBox.FormattingEnabled = true;
            this.tnBox.Items.AddRange(new object[] {
            "3",
            "5"});
            this.tnBox.Location = new System.Drawing.Point(146, 23);
            this.tnBox.Name = "tnBox";
            this.tnBox.Size = new System.Drawing.Size(121, 21);
            this.tnBox.TabIndex = 11;
            this.tnBox.Text = "4";
            this.tnBox.SelectedIndexChanged += new System.EventHandler(this.tnBox_SelectedIndexChanged);
            // 
            // cprBox
            // 
            this.cprBox.Enabled = false;
            this.cprBox.Location = new System.Drawing.Point(146, 193);
            this.cprBox.Name = "cprBox";
            this.cprBox.Size = new System.Drawing.Size(121, 20);
            this.cprBox.TabIndex = 13;
            this.cprBox.Text = "A";
            // 
            // PrintNum
            // 
            this.PrintNum.AutoSize = true;
            this.PrintNum.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.PrintNum.ForeColor = System.Drawing.Color.Red;
            this.PrintNum.Location = new System.Drawing.Point(301, 180);
            this.PrintNum.Name = "PrintNum";
            this.PrintNum.Size = new System.Drawing.Size(68, 12);
            this.PrintNum.TabIndex = 14;
            this.PrintNum.Text = "*PrintNum";
            // 
            // cbPrintNum
            // 
            this.cbPrintNum.FormattingEnabled = true;
            this.cbPrintNum.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
            "29",
            "30"});
            this.cbPrintNum.Location = new System.Drawing.Point(372, 180);
            this.cbPrintNum.Name = "cbPrintNum";
            this.cbPrintNum.Size = new System.Drawing.Size(47, 21);
            this.cbPrintNum.TabIndex = 15;
            this.cbPrintNum.Text = "1";
            // 
            // pwdtb
            // 
            this.pwdtb.Location = new System.Drawing.Point(303, 78);
            this.pwdtb.Name = "pwdtb";
            this.pwdtb.Size = new System.Drawing.Size(119, 20);
            this.pwdtb.TabIndex = 16;
            // 
            // BarcodeHelper_CA
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.DarkCyan;
            this.ClientSize = new System.Drawing.Size(458, 268);
            this.Controls.Add(this.pwdtb);
            this.Controls.Add(this.cbPrintNum);
            this.Controls.Add(this.PrintNum);
            this.Controls.Add(this.cprBox);
            this.Controls.Add(this.tnBox);
            this.Controls.Add(this.rtbtn);
            this.Controls.Add(this.sfcBox);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cpBox);
            this.Controls.Add(this.prtbtn);
            this.Name = "BarcodeHelper_CA";
            this.Text = "BarcodeHelper//FL-34-16500A18-DA";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button prtbtn;
        private System.Windows.Forms.TextBox cpBox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox sfcBox;
        private System.Windows.Forms.Button rtbtn;
        private System.Windows.Forms.ComboBox tnBox;
        private System.Windows.Forms.TextBox cprBox;
        private System.Windows.Forms.Label PrintNum;
        private System.Windows.Forms.ComboBox cbPrintNum;
        private System.Windows.Forms.TextBox pwdtb;
    }
}

