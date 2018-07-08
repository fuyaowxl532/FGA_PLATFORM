namespace FGA_WinForm
{
    partial class BarcodeLifeCycle
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lq = new System.Windows.Forms.Label();
            this.bprint = new System.Windows.Forms.Button();
            this.cbQty = new System.Windows.Forms.ComboBox();
            this.serialNOtb = new System.Windows.Forms.TextBox();
            this.SerialNO = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lq
            // 
            this.lq.AutoSize = true;
            this.lq.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.lq.Location = new System.Drawing.Point(29, 54);
            this.lq.Name = "lq";
            this.lq.Size = new System.Drawing.Size(61, 12);
            this.lq.TabIndex = 0;
            this.lq.Text = "Quantity";
            // 
            // bprint
            // 
            this.bprint.Font = new System.Drawing.Font("SimSun", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.bprint.Location = new System.Drawing.Point(31, 116);
            this.bprint.Name = "bprint";
            this.bprint.Size = new System.Drawing.Size(191, 25);
            this.bprint.TabIndex = 2;
            this.bprint.Text = "PRINT";
            this.bprint.UseVisualStyleBackColor = true;
            this.bprint.Click += new System.EventHandler(this.button1_Click);
            // 
            // cbQty
            // 
            this.cbQty.FormattingEnabled = true;
            this.cbQty.Items.AddRange(new object[] {
            "1",
            "5",
            "10",
            "15",
            "20",
            "25",
            "30",
            "35",
            "40",
            "45",
            "50",
            "55",
            "60"});
            this.cbQty.Location = new System.Drawing.Point(101, 54);
            this.cbQty.Name = "cbQty";
            this.cbQty.Size = new System.Drawing.Size(121, 21);
            this.cbQty.TabIndex = 3;
            this.cbQty.Text = "1";
            // 
            // serialNOtb
            // 
            this.serialNOtb.Location = new System.Drawing.Point(101, 28);
            this.serialNOtb.Name = "serialNOtb";
            this.serialNOtb.Size = new System.Drawing.Size(121, 20);
            this.serialNOtb.TabIndex = 4;
            // 
            // SerialNO
            // 
            this.SerialNO.AutoSize = true;
            this.SerialNO.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SerialNO.Location = new System.Drawing.Point(28, 31);
            this.SerialNO.Name = "SerialNO";
            this.SerialNO.Size = new System.Drawing.Size(65, 15);
            this.SerialNO.TabIndex = 5;
            this.SerialNO.Text = "SerialNO";
            // 
            // BarcodeLifeCycle
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(262, 179);
            this.Controls.Add(this.SerialNO);
            this.Controls.Add(this.serialNOtb);
            this.Controls.Add(this.cbQty);
            this.Controls.Add(this.bprint);
            this.Controls.Add(this.lq);
            this.Name = "BarcodeLifeCycle";
            this.Text = "Label Print";
            this.Load += new System.EventHandler(this.BarcodeLifeCycle_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lq;
        private System.Windows.Forms.Button bprint;
        private System.Windows.Forms.ComboBox cbQty;
        private System.Windows.Forms.TextBox serialNOtb;
        private System.Windows.Forms.Label SerialNO;
    }
}