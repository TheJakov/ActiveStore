namespace ActiveStore.Forme
{
    partial class StatDobavljacaKnjiga
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
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StatDobavljacaKnjiga));
            this.chartUdioDobavljaca = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.btnNazad = new ActiveStore.Klase.FlatButtonNormal();
            this.dgvStatistika = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.chartUdioDobavljaca)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStatistika)).BeginInit();
            this.SuspendLayout();
            // 
            // chartUdioDobavljaca
            // 
            chartArea1.AxisX.LabelStyle.Enabled = false;
            chartArea1.Name = "ChartArea1";
            this.chartUdioDobavljaca.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.chartUdioDobavljaca.Legends.Add(legend1);
            this.chartUdioDobavljaca.Location = new System.Drawing.Point(1, -1);
            this.chartUdioDobavljaca.Name = "chartUdioDobavljaca";
            series1.ChartArea = "ChartArea1";
            series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Pie;
            series1.Legend = "Legend1";
            series1.Name = "Series1";
            this.chartUdioDobavljaca.Series.Add(series1);
            this.chartUdioDobavljaca.Size = new System.Drawing.Size(1184, 666);
            this.chartUdioDobavljaca.TabIndex = 2;
            this.chartUdioDobavljaca.Text = "Udio pojedinog autora";
            // 
            // btnNazad
            // 
            this.btnNazad.BackColor = System.Drawing.Color.White;
            this.btnNazad.BorderThickness = 4F;
            this.btnNazad.Location = new System.Drawing.Point(12, 12);
            this.btnNazad.Name = "btnNazad";
            this.btnNazad.Size = new System.Drawing.Size(124, 43);
            this.btnNazad.TabIndex = 9;
            this.btnNazad.Text = "Nazad";
            this.btnNazad.Click += new System.EventHandler(this.btnNazad_Click);
            // 
            // dgvStatistika
            // 
            this.dgvStatistika.AllowUserToAddRows = false;
            this.dgvStatistika.AllowUserToDeleteRows = false;
            this.dgvStatistika.BackgroundColor = System.Drawing.SystemColors.InactiveCaption;
            this.dgvStatistika.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvStatistika.Location = new System.Drawing.Point(800, 375);
            this.dgvStatistika.MultiSelect = false;
            this.dgvStatistika.Name = "dgvStatistika";
            this.dgvStatistika.ReadOnly = true;
            this.dgvStatistika.RowTemplate.Height = 24;
            this.dgvStatistika.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvStatistika.Size = new System.Drawing.Size(374, 277);
            this.dgvStatistika.TabIndex = 10;
            // 
            // StatDobavljacaKnjiga
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1186, 664);
            this.Controls.Add(this.dgvStatistika);
            this.Controls.Add(this.btnNazad);
            this.Controls.Add(this.chartUdioDobavljaca);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "StatDobavljacaKnjiga";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Udio dobavljača knjiga u narudžbama";
            this.Load += new System.EventHandler(this.StatDobavljacaKnjiga_Load);
            ((System.ComponentModel.ISupportInitialize)(this.chartUdioDobavljaca)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStatistika)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataVisualization.Charting.Chart chartUdioDobavljaca;
        private Klase.FlatButtonNormal btnNazad;
        private System.Windows.Forms.DataGridView dgvStatistika;
    }
}