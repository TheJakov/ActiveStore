namespace ActiveStore
{
    partial class ControlPanel
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ControlPanel));
            this.dgvSkladiste = new System.Windows.Forms.DataGridView();
            this.txtDodajN = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtOduzmiN = new System.Windows.Forms.TextBox();
            this.groupBoxBrzeIzmjene = new System.Windows.Forms.GroupBox();
            this.btnDodajN = new ActiveStore.Klase.FlatButton();
            this.btnDodajJedan = new ActiveStore.Klase.FlatButton();
            this.btnDodajPet = new ActiveStore.Klase.FlatButton();
            this.btnOduzmiN = new ActiveStore.Klase.FlatButtonRed();
            this.btnOduzmiPet = new ActiveStore.Klase.FlatButtonRed();
            this.flatButtonRed1 = new ActiveStore.Klase.FlatButtonRed();
            this.groupBoxStatistika = new System.Windows.Forms.GroupBox();
            this.btnStatDobavljaca = new ActiveStore.Klase.FlatButtonNormal();
            this.btnStatistikaIzdavaca = new ActiveStore.Klase.FlatButtonNormal();
            this.btnStatistikaZanrovi = new ActiveStore.Klase.FlatButtonNormal();
            this.btnUdioAutor = new ActiveStore.Klase.FlatButtonNormal();
            this.btnTopXNarudzbe = new ActiveStore.Klase.FlatButtonNormal();
            this.btnStatKnjigeNaSkladistu = new ActiveStore.Klase.FlatButtonNormal();
            this.btnDnevnik = new ActiveStore.Klase.FlatButtonNormal();
            this.btnUgasi = new ActiveStore.Klase.FlatButtonNormal();
            this.groupBoxSim = new System.Windows.Forms.GroupBox();
            this.btnPokreni = new ActiveStore.Klase.FlatButtonNormal();
            this.label4 = new System.Windows.Forms.Label();
            this.txtInterval = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.labelOpisSim = new System.Windows.Forms.Label();
            this.labelStatus = new System.Windows.Forms.Label();
            this.panelStatus = new System.Windows.Forms.Panel();
            this.btnNarudzbe = new ActiveStore.Klase.FlatButtonNormal();
            this.groupBoxPovijest = new System.Windows.Forms.GroupBox();
            this.simulacijaTimer = new System.Windows.Forms.Timer(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dgvSkladiste)).BeginInit();
            this.groupBoxBrzeIzmjene.SuspendLayout();
            this.groupBoxStatistika.SuspendLayout();
            this.groupBoxSim.SuspendLayout();
            this.groupBoxPovijest.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgvSkladiste
            // 
            this.dgvSkladiste.AllowUserToAddRows = false;
            this.dgvSkladiste.AllowUserToDeleteRows = false;
            this.dgvSkladiste.BackgroundColor = System.Drawing.SystemColors.InactiveCaption;
            this.dgvSkladiste.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvSkladiste.Location = new System.Drawing.Point(613, 12);
            this.dgvSkladiste.MultiSelect = false;
            this.dgvSkladiste.Name = "dgvSkladiste";
            this.dgvSkladiste.ReadOnly = true;
            this.dgvSkladiste.RowTemplate.Height = 24;
            this.dgvSkladiste.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvSkladiste.Size = new System.Drawing.Size(495, 469);
            this.dgvSkladiste.TabIndex = 0;
            this.dgvSkladiste.SelectionChanged += new System.EventHandler(this.dgvSkladiste_SelectionChanged);
            // 
            // txtDodajN
            // 
            this.txtDodajN.Location = new System.Drawing.Point(457, 60);
            this.txtDodajN.Name = "txtDodajN";
            this.txtDodajN.Size = new System.Drawing.Size(100, 22);
            this.txtDodajN.TabIndex = 4;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(457, 37);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(22, 17);
            this.label1.TabIndex = 5;
            this.label1.Text = "N:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(457, 97);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(22, 17);
            this.label2.TabIndex = 11;
            this.label2.Text = "N:";
            // 
            // txtOduzmiN
            // 
            this.txtOduzmiN.Location = new System.Drawing.Point(457, 120);
            this.txtOduzmiN.Name = "txtOduzmiN";
            this.txtOduzmiN.Size = new System.Drawing.Size(100, 22);
            this.txtOduzmiN.TabIndex = 10;
            // 
            // groupBoxBrzeIzmjene
            // 
            this.groupBoxBrzeIzmjene.BackColor = System.Drawing.Color.LightGray;
            this.groupBoxBrzeIzmjene.Controls.Add(this.btnDodajN);
            this.groupBoxBrzeIzmjene.Controls.Add(this.label2);
            this.groupBoxBrzeIzmjene.Controls.Add(this.btnDodajJedan);
            this.groupBoxBrzeIzmjene.Controls.Add(this.txtOduzmiN);
            this.groupBoxBrzeIzmjene.Controls.Add(this.btnDodajPet);
            this.groupBoxBrzeIzmjene.Controls.Add(this.btnOduzmiN);
            this.groupBoxBrzeIzmjene.Controls.Add(this.txtDodajN);
            this.groupBoxBrzeIzmjene.Controls.Add(this.btnOduzmiPet);
            this.groupBoxBrzeIzmjene.Controls.Add(this.label1);
            this.groupBoxBrzeIzmjene.Controls.Add(this.flatButtonRed1);
            this.groupBoxBrzeIzmjene.Location = new System.Drawing.Point(12, 12);
            this.groupBoxBrzeIzmjene.Name = "groupBoxBrzeIzmjene";
            this.groupBoxBrzeIzmjene.Size = new System.Drawing.Size(573, 171);
            this.groupBoxBrzeIzmjene.TabIndex = 12;
            this.groupBoxBrzeIzmjene.TabStop = false;
            this.groupBoxBrzeIzmjene.Text = "Brze izmjene količine";
            // 
            // btnDodajN
            // 
            this.btnDodajN.BackColor = System.Drawing.Color.White;
            this.btnDodajN.BorderThickness = 4F;
            this.btnDodajN.ForeColor = System.Drawing.Color.Black;
            this.btnDodajN.Location = new System.Drawing.Point(319, 38);
            this.btnDodajN.Name = "btnDodajN";
            this.btnDodajN.Size = new System.Drawing.Size(120, 44);
            this.btnDodajN.TabIndex = 3;
            this.btnDodajN.Text = "Dodaj N";
            this.btnDodajN.Click += new System.EventHandler(this.btnDodajN_Click);
            // 
            // btnDodajJedan
            // 
            this.btnDodajJedan.BackColor = System.Drawing.Color.White;
            this.btnDodajJedan.BorderThickness = 4F;
            this.btnDodajJedan.ForeColor = System.Drawing.Color.Black;
            this.btnDodajJedan.Location = new System.Drawing.Point(21, 38);
            this.btnDodajJedan.Name = "btnDodajJedan";
            this.btnDodajJedan.Size = new System.Drawing.Size(120, 44);
            this.btnDodajJedan.TabIndex = 1;
            this.btnDodajJedan.Text = "Dodaj 1";
            this.btnDodajJedan.Click += new System.EventHandler(this.btnDodajJedan_Click);
            // 
            // btnDodajPet
            // 
            this.btnDodajPet.BackColor = System.Drawing.Color.White;
            this.btnDodajPet.BorderThickness = 4F;
            this.btnDodajPet.ForeColor = System.Drawing.Color.Black;
            this.btnDodajPet.Location = new System.Drawing.Point(168, 38);
            this.btnDodajPet.Name = "btnDodajPet";
            this.btnDodajPet.Size = new System.Drawing.Size(120, 44);
            this.btnDodajPet.TabIndex = 2;
            this.btnDodajPet.Text = "Dodaj 5";
            this.btnDodajPet.Click += new System.EventHandler(this.btnDodajPet_Click);
            // 
            // btnOduzmiN
            // 
            this.btnOduzmiN.BackColor = System.Drawing.Color.White;
            this.btnOduzmiN.BorderThickness = 4F;
            this.btnOduzmiN.Location = new System.Drawing.Point(319, 98);
            this.btnOduzmiN.Name = "btnOduzmiN";
            this.btnOduzmiN.Size = new System.Drawing.Size(120, 44);
            this.btnOduzmiN.TabIndex = 9;
            this.btnOduzmiN.Text = "Oduzmi N";
            this.btnOduzmiN.Click += new System.EventHandler(this.btnOduzmiN_Click);
            // 
            // btnOduzmiPet
            // 
            this.btnOduzmiPet.BackColor = System.Drawing.Color.White;
            this.btnOduzmiPet.BorderThickness = 4F;
            this.btnOduzmiPet.Location = new System.Drawing.Point(168, 98);
            this.btnOduzmiPet.Name = "btnOduzmiPet";
            this.btnOduzmiPet.Size = new System.Drawing.Size(120, 44);
            this.btnOduzmiPet.TabIndex = 8;
            this.btnOduzmiPet.Text = "Oduzmi 5";
            this.btnOduzmiPet.Click += new System.EventHandler(this.btnOduzmiPet_Click);
            // 
            // flatButtonRed1
            // 
            this.flatButtonRed1.BackColor = System.Drawing.Color.White;
            this.flatButtonRed1.BorderThickness = 4F;
            this.flatButtonRed1.Location = new System.Drawing.Point(21, 98);
            this.flatButtonRed1.Name = "flatButtonRed1";
            this.flatButtonRed1.Size = new System.Drawing.Size(120, 44);
            this.flatButtonRed1.TabIndex = 7;
            this.flatButtonRed1.Text = "Oduzmi 1";
            this.flatButtonRed1.Click += new System.EventHandler(this.flatButtonRed1_Click);
            // 
            // groupBoxStatistika
            // 
            this.groupBoxStatistika.BackColor = System.Drawing.Color.PaleTurquoise;
            this.groupBoxStatistika.Controls.Add(this.btnStatDobavljaca);
            this.groupBoxStatistika.Controls.Add(this.btnStatistikaIzdavaca);
            this.groupBoxStatistika.Controls.Add(this.btnStatistikaZanrovi);
            this.groupBoxStatistika.Controls.Add(this.btnUdioAutor);
            this.groupBoxStatistika.Controls.Add(this.btnTopXNarudzbe);
            this.groupBoxStatistika.Controls.Add(this.btnStatKnjigeNaSkladistu);
            this.groupBoxStatistika.Location = new System.Drawing.Point(12, 381);
            this.groupBoxStatistika.Name = "groupBoxStatistika";
            this.groupBoxStatistika.Size = new System.Drawing.Size(573, 201);
            this.groupBoxStatistika.TabIndex = 13;
            this.groupBoxStatistika.TabStop = false;
            this.groupBoxStatistika.Text = "Statistika";
            // 
            // btnStatDobavljaca
            // 
            this.btnStatDobavljaca.BackColor = System.Drawing.Color.White;
            this.btnStatDobavljaca.BorderThickness = 4F;
            this.btnStatDobavljaca.Location = new System.Drawing.Point(393, 129);
            this.btnStatDobavljaca.Name = "btnStatDobavljaca";
            this.btnStatDobavljaca.Size = new System.Drawing.Size(123, 42);
            this.btnStatDobavljaca.TabIndex = 20;
            this.btnStatDobavljaca.Text = "Statistika dobavljača";
            this.btnStatDobavljaca.Click += new System.EventHandler(this.btnStatDobavljaca_Click);
            // 
            // btnStatistikaIzdavaca
            // 
            this.btnStatistikaIzdavaca.BackColor = System.Drawing.Color.White;
            this.btnStatistikaIzdavaca.BorderThickness = 4F;
            this.btnStatistikaIzdavaca.Location = new System.Drawing.Point(206, 129);
            this.btnStatistikaIzdavaca.Name = "btnStatistikaIzdavaca";
            this.btnStatistikaIzdavaca.Size = new System.Drawing.Size(123, 42);
            this.btnStatistikaIzdavaca.TabIndex = 19;
            this.btnStatistikaIzdavaca.Text = "Statistika izdavača";
            this.btnStatistikaIzdavaca.Click += new System.EventHandler(this.btnStatistikaIzdavaca_Click);
            // 
            // btnStatistikaZanrovi
            // 
            this.btnStatistikaZanrovi.BackColor = System.Drawing.Color.White;
            this.btnStatistikaZanrovi.BorderThickness = 4F;
            this.btnStatistikaZanrovi.Location = new System.Drawing.Point(21, 129);
            this.btnStatistikaZanrovi.Name = "btnStatistikaZanrovi";
            this.btnStatistikaZanrovi.Size = new System.Drawing.Size(123, 42);
            this.btnStatistikaZanrovi.TabIndex = 18;
            this.btnStatistikaZanrovi.Text = "Statistika žanrova";
            this.btnStatistikaZanrovi.Click += new System.EventHandler(this.btnStatistikaZanrovi_Click);
            // 
            // btnUdioAutor
            // 
            this.btnUdioAutor.BackColor = System.Drawing.Color.White;
            this.btnUdioAutor.BorderThickness = 4F;
            this.btnUdioAutor.Location = new System.Drawing.Point(393, 41);
            this.btnUdioAutor.Name = "btnUdioAutor";
            this.btnUdioAutor.Size = new System.Drawing.Size(123, 42);
            this.btnUdioAutor.TabIndex = 17;
            this.btnUdioAutor.Text = "Statistika autora knjiga";
            this.btnUdioAutor.Click += new System.EventHandler(this.btnUdioAutor_Click);
            // 
            // btnTopXNarudzbe
            // 
            this.btnTopXNarudzbe.BackColor = System.Drawing.Color.White;
            this.btnTopXNarudzbe.BorderThickness = 4F;
            this.btnTopXNarudzbe.Location = new System.Drawing.Point(206, 41);
            this.btnTopXNarudzbe.Name = "btnTopXNarudzbe";
            this.btnTopXNarudzbe.Size = new System.Drawing.Size(123, 42);
            this.btnTopXNarudzbe.TabIndex = 16;
            this.btnTopXNarudzbe.Text = "Top X naručivanih";
            this.btnTopXNarudzbe.Click += new System.EventHandler(this.btnTopXNarudzbe_Click);
            // 
            // btnStatKnjigeNaSkladistu
            // 
            this.btnStatKnjigeNaSkladistu.BackColor = System.Drawing.Color.White;
            this.btnStatKnjigeNaSkladistu.BorderThickness = 4F;
            this.btnStatKnjigeNaSkladistu.Location = new System.Drawing.Point(21, 41);
            this.btnStatKnjigeNaSkladistu.Name = "btnStatKnjigeNaSkladistu";
            this.btnStatKnjigeNaSkladistu.Size = new System.Drawing.Size(123, 42);
            this.btnStatKnjigeNaSkladistu.TabIndex = 15;
            this.btnStatKnjigeNaSkladistu.Text = "Udio knjige na skladištu";
            this.btnStatKnjigeNaSkladistu.Click += new System.EventHandler(this.btnStatKnjigeNaSkladistu_Click);
            // 
            // btnDnevnik
            // 
            this.btnDnevnik.BackColor = System.Drawing.Color.White;
            this.btnDnevnik.BorderThickness = 4F;
            this.btnDnevnik.Location = new System.Drawing.Point(27, 31);
            this.btnDnevnik.Name = "btnDnevnik";
            this.btnDnevnik.Size = new System.Drawing.Size(123, 42);
            this.btnDnevnik.TabIndex = 14;
            this.btnDnevnik.Text = "DNEVNIK";
            this.btnDnevnik.Click += new System.EventHandler(this.btnDnevnik_Click);
            // 
            // btnUgasi
            // 
            this.btnUgasi.BorderThickness = 4F;
            this.btnUgasi.Location = new System.Drawing.Point(985, 540);
            this.btnUgasi.Name = "btnUgasi";
            this.btnUgasi.Size = new System.Drawing.Size(123, 42);
            this.btnUgasi.TabIndex = 6;
            this.btnUgasi.Text = "ZATVORI PROGRAM";
            this.btnUgasi.Click += new System.EventHandler(this.btnUgasi_Click);
            // 
            // groupBoxSim
            // 
            this.groupBoxSim.BackColor = System.Drawing.Color.Khaki;
            this.groupBoxSim.Controls.Add(this.btnPokreni);
            this.groupBoxSim.Controls.Add(this.label4);
            this.groupBoxSim.Controls.Add(this.txtInterval);
            this.groupBoxSim.Controls.Add(this.label3);
            this.groupBoxSim.Controls.Add(this.labelOpisSim);
            this.groupBoxSim.Controls.Add(this.labelStatus);
            this.groupBoxSim.Controls.Add(this.panelStatus);
            this.groupBoxSim.Location = new System.Drawing.Point(12, 253);
            this.groupBoxSim.Name = "groupBoxSim";
            this.groupBoxSim.Size = new System.Drawing.Size(573, 112);
            this.groupBoxSim.TabIndex = 15;
            this.groupBoxSim.TabStop = false;
            this.groupBoxSim.Text = "Simulacija";
            // 
            // btnPokreni
            // 
            this.btnPokreni.BackColor = System.Drawing.Color.White;
            this.btnPokreni.BorderThickness = 4F;
            this.btnPokreni.Location = new System.Drawing.Point(319, 13);
            this.btnPokreni.Name = "btnPokreni";
            this.btnPokreni.Size = new System.Drawing.Size(100, 42);
            this.btnPokreni.TabIndex = 17;
            this.btnPokreni.Text = "POKRENI";
            this.btnPokreni.Click += new System.EventHandler(this.btnPokreni_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(160, 49);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(64, 17);
            this.label4.TabIndex = 5;
            this.label4.Text = "sekundi";
            // 
            // txtInterval
            // 
            this.txtInterval.Location = new System.Drawing.Point(87, 49);
            this.txtInterval.Name = "txtInterval";
            this.txtInterval.Size = new System.Drawing.Size(67, 22);
            this.txtInterval.TabIndex = 4;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(18, 49);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(62, 17);
            this.label3.TabIndex = 3;
            this.label3.Text = "Interval";
            // 
            // labelOpisSim
            // 
            this.labelOpisSim.AutoSize = true;
            this.labelOpisSim.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelOpisSim.Location = new System.Drawing.Point(6, 92);
            this.labelOpisSim.Name = "labelOpisSim";
            this.labelOpisSim.Size = new System.Drawing.Size(541, 17);
            this.labelOpisSim.TabIndex = 2;
            this.labelOpisSim.Text = "Svako N sekundi se oduzima nasumična količina (1-10) nasumičnoj knjizi u skladišt" +
    "u.";
            // 
            // labelStatus
            // 
            this.labelStatus.AutoSize = true;
            this.labelStatus.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelStatus.Location = new System.Drawing.Point(478, 58);
            this.labelStatus.Name = "labelStatus";
            this.labelStatus.Size = new System.Drawing.Size(89, 17);
            this.labelStatus.TabIndex = 1;
            this.labelStatus.Text = "Zaustavljeno";
            this.labelStatus.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // panelStatus
            // 
            this.panelStatus.BackColor = System.Drawing.Color.Red;
            this.panelStatus.Location = new System.Drawing.Point(507, 10);
            this.panelStatus.Name = "panelStatus";
            this.panelStatus.Size = new System.Drawing.Size(50, 45);
            this.panelStatus.TabIndex = 0;
            // 
            // btnNarudzbe
            // 
            this.btnNarudzbe.BackColor = System.Drawing.Color.White;
            this.btnNarudzbe.BorderThickness = 4F;
            this.btnNarudzbe.Location = new System.Drawing.Point(173, 31);
            this.btnNarudzbe.Name = "btnNarudzbe";
            this.btnNarudzbe.Size = new System.Drawing.Size(123, 42);
            this.btnNarudzbe.TabIndex = 16;
            this.btnNarudzbe.Text = "NARUDŽBE";
            this.btnNarudzbe.Click += new System.EventHandler(this.btnNarudzbe_Click);
            // 
            // groupBoxPovijest
            // 
            this.groupBoxPovijest.BackColor = System.Drawing.Color.LightSalmon;
            this.groupBoxPovijest.Controls.Add(this.btnNarudzbe);
            this.groupBoxPovijest.Controls.Add(this.btnDnevnik);
            this.groupBoxPovijest.Location = new System.Drawing.Point(613, 494);
            this.groupBoxPovijest.Name = "groupBoxPovijest";
            this.groupBoxPovijest.Size = new System.Drawing.Size(318, 88);
            this.groupBoxPovijest.TabIndex = 17;
            this.groupBoxPovijest.TabStop = false;
            this.groupBoxPovijest.Text = "Pregled";
            // 
            // simulacijaTimer
            // 
            this.simulacijaTimer.Interval = 10000;
            this.simulacijaTimer.Tick += new System.EventHandler(this.simulacijaTimer_Tick);
            // 
            // ControlPanel
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1120, 594);
            this.Controls.Add(this.groupBoxPovijest);
            this.Controls.Add(this.groupBoxSim);
            this.Controls.Add(this.groupBoxStatistika);
            this.Controls.Add(this.groupBoxBrzeIzmjene);
            this.Controls.Add(this.btnUgasi);
            this.Controls.Add(this.dgvSkladiste);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "ControlPanel";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Control panel - ActiveStore";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvSkladiste)).EndInit();
            this.groupBoxBrzeIzmjene.ResumeLayout(false);
            this.groupBoxBrzeIzmjene.PerformLayout();
            this.groupBoxStatistika.ResumeLayout(false);
            this.groupBoxSim.ResumeLayout(false);
            this.groupBoxSim.PerformLayout();
            this.groupBoxPovijest.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvSkladiste;
        private Klase.FlatButton btnDodajJedan;
        private Klase.FlatButton btnDodajPet;
        private Klase.FlatButton btnDodajN;
        private System.Windows.Forms.TextBox txtDodajN;
        private System.Windows.Forms.Label label1;
        private Klase.FlatButtonNormal btnUgasi;
        private Klase.FlatButtonRed flatButtonRed1;
        private Klase.FlatButtonRed btnOduzmiPet;
        private Klase.FlatButtonRed btnOduzmiN;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtOduzmiN;
        private System.Windows.Forms.GroupBox groupBoxBrzeIzmjene;
        private System.Windows.Forms.GroupBox groupBoxStatistika;
        private Klase.FlatButtonNormal btnDnevnik;
        private Klase.FlatButtonNormal btnStatKnjigeNaSkladistu;
        private Klase.FlatButtonNormal btnTopXNarudzbe;
        private Klase.FlatButtonNormal btnUdioAutor;
        private Klase.FlatButtonNormal btnStatistikaZanrovi;
        private Klase.FlatButtonNormal btnStatistikaIzdavaca;
        private Klase.FlatButtonNormal btnStatDobavljaca;
        private System.Windows.Forms.GroupBox groupBoxSim;
        private Klase.FlatButtonNormal btnNarudzbe;
        private System.Windows.Forms.GroupBox groupBoxPovijest;
        private System.Windows.Forms.Label labelStatus;
        private System.Windows.Forms.Panel panelStatus;
        private System.Windows.Forms.Label labelOpisSim;
        private Klase.FlatButtonNormal btnPokreni;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtInterval;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Timer simulacijaTimer;
    }
}

