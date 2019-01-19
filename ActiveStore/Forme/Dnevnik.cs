using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ActiveStore.Klase;
using ActiveStore.Forme;
using Npgsql;

namespace ActiveStore.Forme
{
    public partial class Dnevnik : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public Dnevnik()
        {
            InitializeComponent();
        }

        private void OsvjeziDnevnik(NpgsqlConnection conn)
        {
            string upit = "SELECT \"Dnevnik\".\"ID\", \"Tip\".\"Naziv\", \"Dnevnik\".\"vk_knjiga\", \"Dnevnik\"" +
                ".\"Tekst\", \"Dnevnik\".\"Datum\" " +
                "FROM \"Dnevnik\", \"Tip\" " +
                "WHERE \"Dnevnik\".\"vk_tip\" = \"Tip\".\"ID\" " +
                "ORDER BY 1 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet skladisteDs = new DataSet();

            dataAdapter.Fill(skladisteDs);
            dgvDnevnik.DataSource = skladisteDs.Tables[0];
            dgvDnevnik.Columns[0].HeaderText = "Redni broj";
            dgvDnevnik.Columns[0].Width = 64;
            dgvDnevnik.Columns[1].HeaderText = "Tip";
            dgvDnevnik.Columns[1].Width = 104;
            dgvDnevnik.Columns[2].HeaderText = "Šifra knjige";
            dgvDnevnik.Columns[2].Width = 64;
            dgvDnevnik.Columns[3].HeaderText = "Događaj";
            dgvDnevnik.Columns[3].Width = 296;
        }

        private void Dnevnik_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziDnevnik(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            txtSifraKnjige.Clear();
            txtTip.Clear();
            dateOd.Value = DateTime.Now;
            dateDo.Value = DateTime.Now;

            mojaKonekcija.OtvoriKonekciju();
            OsvjeziDnevnik(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void btnNazad_Click(object sender, EventArgs e)
        {
            ControlPanel frmControl = new ControlPanel();
            this.Hide();
            frmControl.ShowDialog();
            this.Close();
        }

        private void txtSifraKnjige_TextChanged(object sender, EventArgs e)
        {
            txtTip.Clear();
            if (txtSifraKnjige.Text.Length > 0)
            {
                int sifra;
                int.TryParse(txtSifraKnjige.Text, out sifra);
                string upit = "SELECT \"Dnevnik\".\"ID\", \"Tip\".\"Naziv\", \"Dnevnik\".\"vk_knjiga\", \"Dnevnik\"" +
                ".\"Tekst\", \"Dnevnik\".\"Datum\" " +
                "FROM \"Dnevnik\", \"Tip\" " +
                "WHERE \"Dnevnik\".\"vk_tip\" = \"Tip\".\"ID\" " +
                "AND \"Dnevnik\".\"vk_knjiga\" = "+sifra+" "+
                "ORDER BY 1 DESC";

                NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, mojaKonekcija.conn);
                DataSet skladisteDs = new DataSet();

                dataAdapter.Fill(skladisteDs);
                dgvDnevnik.DataSource = skladisteDs.Tables[0];
                dgvDnevnik.Columns[0].HeaderText = "Redni broj";
                dgvDnevnik.Columns[0].Width = 64;
                dgvDnevnik.Columns[1].HeaderText = "Tip";
                dgvDnevnik.Columns[1].Width = 104;
                dgvDnevnik.Columns[2].HeaderText = "Šifra knjige";
                dgvDnevnik.Columns[2].Width = 64;
                dgvDnevnik.Columns[3].HeaderText = "Događaj";
                dgvDnevnik.Columns[3].Width = 296;
            }
        }

        private void txtTip_TextChanged(object sender, EventArgs e)
        {
            txtSifraKnjige.Clear();
            string upit = "SELECT \"Dnevnik\".\"ID\", \"Tip\".\"Naziv\", \"Dnevnik\".\"vk_knjiga\", \"Dnevnik\"" +
                ".\"Tekst\", \"Dnevnik\".\"Datum\" " +
                "FROM \"Dnevnik\", \"Tip\" " +
                "WHERE \"Dnevnik\".\"vk_tip\" = \"Tip\".\"ID\" " +
                "AND \"Tip\".\"Naziv\" LIKE '" + txtTip.Text + "%' " +
                "ORDER BY 1 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, mojaKonekcija.conn);
            DataSet skladisteDs = new DataSet();

            dataAdapter.Fill(skladisteDs);
            dgvDnevnik.DataSource = skladisteDs.Tables[0];
            dgvDnevnik.Columns[0].HeaderText = "Redni broj";
            dgvDnevnik.Columns[0].Width = 64;
            dgvDnevnik.Columns[1].HeaderText = "Tip";
            dgvDnevnik.Columns[1].Width = 104;
            dgvDnevnik.Columns[2].HeaderText = "Šifra knjige";
            dgvDnevnik.Columns[2].Width = 64;
            dgvDnevnik.Columns[3].HeaderText = "Događaj";
            dgvDnevnik.Columns[3].Width = 296;
        }

        private void PretraziPoDatumu()
        {
            txtSifraKnjige.Clear();
            txtTip.Clear();

            if (dateOd.Text.Length > 0 && dateDo.Text.Length > 0)
            {
                string upit = "SELECT \"Dnevnik\".\"ID\", \"Tip\".\"Naziv\", \"Dnevnik\".\"vk_knjiga\", \"Dnevnik\"" +
                ".\"Tekst\", \"Dnevnik\".\"Datum\" " +
                "FROM \"Dnevnik\", \"Tip\" " +
                "WHERE \"Dnevnik\".\"vk_tip\" = \"Tip\".\"ID\" " +
                "AND \"Dnevnik\".\"Datum\" BETWEEN '" + dateOd.Value.Date + "'::timestamp AND '"+dateDo.Value+"'::timestamp "+
                "ORDER BY 1 DESC";

                NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, mojaKonekcija.conn);
                DataSet skladisteDs = new DataSet();

                dataAdapter.Fill(skladisteDs);
                dgvDnevnik.DataSource = skladisteDs.Tables[0];
                dgvDnevnik.Columns[0].HeaderText = "Redni broj";
                dgvDnevnik.Columns[0].Width = 64;
                dgvDnevnik.Columns[1].HeaderText = "Tip";
                dgvDnevnik.Columns[1].Width = 104;
                dgvDnevnik.Columns[2].HeaderText = "Šifra knjige";
                dgvDnevnik.Columns[2].Width = 64;
                dgvDnevnik.Columns[3].HeaderText = "Događaj";
                dgvDnevnik.Columns[3].Width = 296;
            }
        }

        private void dateOd_ValueChanged(object sender, EventArgs e)
        {
            PretraziPoDatumu();
        }

        private void dateDo_ValueChanged(object sender, EventArgs e)
        {
            PretraziPoDatumu();
        }
    }
}
