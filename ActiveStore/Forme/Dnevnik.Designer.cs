namespace ActiveStore.Forme
{
    partial class Dnevnik
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Dnevnik));
            this.dgvDnevnik = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dateDo = new System.Windows.Forms.DateTimePicker();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.dateOd = new System.Windows.Forms.DateTimePicker();
            this.txtTip = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtSifraKnjige = new System.Windows.Forms.TextBox();
            this.btnReset = new ActiveStore.Klase.FlatButtonNormal();
            this.label2 = new System.Windows.Forms.Label();
            this.btnNazad = new ActiveStore.Klase.FlatButtonNormal();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDnevnik)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgvDnevnik
            // 
            this.dgvDnevnik.AllowUserToAddRows = false;
            this.dgvDnevnik.AllowUserToDeleteRows = false;
            this.dgvDnevnik.BackgroundColor = System.Drawing.SystemColors.InactiveCaption;
            this.dgvDnevnik.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDnevnik.Location = new System.Drawing.Point(12, 253);
            this.dgvDnevnik.MultiSelect = false;
            this.dgvDnevnik.Name = "dgvDnevnik";
            this.dgvDnevnik.ReadOnly = true;
            this.dgvDnevnik.RowTemplate.Height = 24;
            this.dgvDnevnik.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvDnevnik.Size = new System.Drawing.Size(917, 432);
            this.dgvDnevnik.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(386, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(163, 46);
            this.label1.TabIndex = 2;
            this.label1.Text = "Dnevnik";
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.LightSalmon;
            this.groupBox1.Controls.Add(this.dateDo);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.dateOd);
            this.groupBox1.Controls.Add(this.txtTip);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.txtSifraKnjige);
            this.groupBox1.Controls.Add(this.btnReset);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 82);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(917, 165);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Filtriranje";
            // 
            // dateDo
            // 
            this.dateDo.Location = new System.Drawing.Point(583, 125);
            this.dateDo.Name = "dateDo";
            this.dateDo.Size = new System.Drawing.Size(202, 24);
            this.dateDo.TabIndex = 11;
            this.dateDo.ValueChanged += new System.EventHandler(this.dateDo_ValueChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(512, 124);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(34, 25);
            this.label5.TabIndex = 10;
            this.label5.Text = "do";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(15, 125);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(111, 25);
            this.label4.TabIndex = 9;
            this.label4.Text = "Pretraži od:";
            // 
            // dateOd
            // 
            this.dateOd.Location = new System.Drawing.Point(271, 126);
            this.dateOd.Name = "dateOd";
            this.dateOd.Size = new System.Drawing.Size(202, 24);
            this.dateOd.TabIndex = 8;
            this.dateOd.ValueChanged += new System.EventHandler(this.dateOd_ValueChanged);
            // 
            // txtTip
            // 
            this.txtTip.Location = new System.Drawing.Point(271, 86);
            this.txtTip.Name = "txtTip";
            this.txtTip.Size = new System.Drawing.Size(202, 24);
            this.txtTip.TabIndex = 7;
            this.txtTip.TextChanged += new System.EventHandler(this.txtTip_TextChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(15, 84);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(147, 25);
            this.label3.TabIndex = 6;
            this.label3.Text = "Pretraži po tipu:";
            // 
            // txtSifraKnjige
            // 
            this.txtSifraKnjige.Location = new System.Drawing.Point(271, 35);
            this.txtSifraKnjige.Name = "txtSifraKnjige";
            this.txtSifraKnjige.Size = new System.Drawing.Size(100, 24);
            this.txtSifraKnjige.TabIndex = 5;
            this.txtSifraKnjige.TextChanged += new System.EventHandler(this.txtSifraKnjige_TextChanged);
            // 
            // btnReset
            // 
            this.btnReset.BackColor = System.Drawing.Color.White;
            this.btnReset.BorderThickness = 4F;
            this.btnReset.Location = new System.Drawing.Point(778, 23);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(124, 43);
            this.btnReset.TabIndex = 4;
            this.btnReset.Text = "Resetiraj";
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(15, 33);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(201, 25);
            this.label2.TabIndex = 0;
            this.label2.Text = "Pretraži po šifri knjige:";
            // 
            // btnNazad
            // 
            this.btnNazad.BackColor = System.Drawing.Color.White;
            this.btnNazad.BorderThickness = 4F;
            this.btnNazad.Location = new System.Drawing.Point(12, 12);
            this.btnNazad.Name = "btnNazad";
            this.btnNazad.Size = new System.Drawing.Size(124, 43);
            this.btnNazad.TabIndex = 6;
            this.btnNazad.Text = "Nazad";
            this.btnNazad.Click += new System.EventHandler(this.btnNazad_Click);
            // 
            // Dnevnik
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(941, 697);
            this.Controls.Add(this.btnNazad);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dgvDnevnik);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Dnevnik";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Dnevnik";
            this.Load += new System.EventHandler(this.Dnevnik_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDnevnik)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvDnevnik;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private Klase.FlatButtonNormal btnReset;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtSifraKnjige;
        private Klase.FlatButtonNormal btnNazad;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtTip;
        private System.Windows.Forms.DateTimePicker dateOd;
        private System.Windows.Forms.DateTimePicker dateDo;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
    }
}