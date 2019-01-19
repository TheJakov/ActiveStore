namespace ActiveStore.Forme
{
    partial class StatZanrovaKnjiga
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StatZanrovaKnjiga));
            this.chartUdioZanrova = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.dgvStatistika = new System.Windows.Forms.DataGridView();
            this.btnNazad = new ActiveStore.Klase.FlatButtonNormal();
            ((System.ComponentModel.ISupportInitialize)(this.chartUdioZanrova)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStatistika)).BeginInit();
            this.SuspendLayout();
            // 
            // chartUdioZanrova
            // 
            chartArea1.AxisX.LabelStyle.Enabled = false;
            chartArea1.Name = "ChartArea1";
            this.chartUdioZanrova.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.chartUdioZanrova.Legends.Add(legend1);
            this.chartUdioZanrova.Location = new System.Drawing.Point(1, -1);
            this.chartUdioZanrova.Name = "chartUdioZanrova";
            series1.ChartArea = "ChartArea1";
            series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Pie;
            series1.Legend = "Legend1";
            series1.Name = "Series1";
            this.chartUdioZanrova.Series.Add(series1);
            this.chartUdioZanrova.Size = new System.Drawing.Size(1184, 666);
            this.chartUdioZanrova.TabIndex = 2;
            this.chartUdioZanrova.Text = "Udio pojedinog autora";
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
            // btnNazad
            // 
            this.btnNazad.BackColor = System.Drawing.Color.White;
            this.btnNazad.BorderThickness = 4F;
            this.btnNazad.Location = new System.Drawing.Point(12, 12);
            this.btnNazad.Name = "btnNazad";
            this.btnNazad.Size = new System.Drawing.Size(124, 43);
            this.btnNazad.TabIndex = 11;
            this.btnNazad.Text = "Nazad";
            this.btnNazad.Click += new System.EventHandler(this.btnNazad_Click);
            // 
            // StatZanrovaKnjiga
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1186, 664);
            this.Controls.Add(this.btnNazad);
            this.Controls.Add(this.dgvStatistika);
            this.Controls.Add(this.chartUdioZanrova);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "StatZanrovaKnjiga";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Udio žanrova u knjigama na skladištu";
            this.Load += new System.EventHandler(this.StatZanrovaKnjiga_Load);
            ((System.ComponentModel.ISupportInitialize)(this.chartUdioZanrova)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStatistika)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataVisualization.Charting.Chart chartUdioZanrova;
        private System.Windows.Forms.DataGridView dgvStatistika;
        private Klase.FlatButtonNormal btnNazad;
    }
}