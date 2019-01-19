namespace ActiveStore.Forme
{
    partial class StatTopXNarudzbe
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StatTopXNarudzbe));
            this.dgvTopNarudzbe = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtTopBroj = new System.Windows.Forms.TextBox();
            this.btnReset = new ActiveStore.Klase.FlatButtonNormal();
            this.btnNazad = new ActiveStore.Klase.FlatButtonNormal();
            ((System.ComponentModel.ISupportInitialize)(this.dgvTopNarudzbe)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvTopNarudzbe
            // 
            this.dgvTopNarudzbe.AllowUserToAddRows = false;
            this.dgvTopNarudzbe.AllowUserToDeleteRows = false;
            this.dgvTopNarudzbe.BackgroundColor = System.Drawing.SystemColors.InactiveCaption;
            this.dgvTopNarudzbe.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvTopNarudzbe.Location = new System.Drawing.Point(44, 211);
            this.dgvTopNarudzbe.MultiSelect = false;
            this.dgvTopNarudzbe.Name = "dgvTopNarudzbe";
            this.dgvTopNarudzbe.ReadOnly = true;
            this.dgvTopNarudzbe.RowTemplate.Height = 24;
            this.dgvTopNarudzbe.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvTopNarudzbe.Size = new System.Drawing.Size(433, 382);
            this.dgvTopNarudzbe.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(104, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(310, 31);
            this.label1.TabIndex = 2;
            this.label1.Text = "Top X naručivanih knjiga";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(173, 153);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(40, 31);
            this.label2.TabIndex = 3;
            this.label2.Text = "X:";
            // 
            // txtTopBroj
            // 
            this.txtTopBroj.Location = new System.Drawing.Point(219, 163);
            this.txtTopBroj.Name = "txtTopBroj";
            this.txtTopBroj.Size = new System.Drawing.Size(100, 22);
            this.txtTopBroj.TabIndex = 4;
            this.txtTopBroj.TextChanged += new System.EventHandler(this.txtTopBroj_TextChanged);
            // 
            // btnReset
            // 
            this.btnReset.BackColor = System.Drawing.Color.White;
            this.btnReset.BorderThickness = 4F;
            this.btnReset.Location = new System.Drawing.Point(353, 153);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(124, 43);
            this.btnReset.TabIndex = 5;
            this.btnReset.Text = "Resetiraj";
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // btnNazad
            // 
            this.btnNazad.BackColor = System.Drawing.Color.White;
            this.btnNazad.BorderThickness = 4F;
            this.btnNazad.Location = new System.Drawing.Point(12, 11);
            this.btnNazad.Name = "btnNazad";
            this.btnNazad.Size = new System.Drawing.Size(84, 43);
            this.btnNazad.TabIndex = 6;
            this.btnNazad.Text = "Nazad";
            this.btnNazad.Click += new System.EventHandler(this.btnNazad_Click);
            // 
            // StatTopXNarudzbe
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(520, 605);
            this.Controls.Add(this.btnNazad);
            this.Controls.Add(this.btnReset);
            this.Controls.Add(this.txtTopBroj);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dgvTopNarudzbe);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "StatTopXNarudzbe";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Top X naručivanih";
            this.Load += new System.EventHandler(this.StatTopXNarudzbe_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvTopNarudzbe)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvTopNarudzbe;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtTopBroj;
        private Klase.FlatButtonNormal btnReset;
        private Klase.FlatButtonNormal btnNazad;
    }
}