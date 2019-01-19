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
    public partial class StatTopXNarudzbe : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public StatTopXNarudzbe()
        {
            InitializeComponent();
        }

        private void txtTopBroj_TextChanged(object sender, EventArgs e)
        {
            int broj;
            if (int.TryParse(txtTopBroj.Text, out broj))
            {
                if (broj > 0)
                {
                    OsvjeziPodatke(mojaKonekcija.conn, broj);
                }
            }
        }

        private void StatTopXNarudzbe_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziPodatke(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
            txtTopBroj.Text = "5";
        }

        private void OsvjeziPodatke(NpgsqlConnection conn)
        {
            string upit =
                "SELECT \"Knjiga\".\"Naslov\", SUM(\"Narudzba\".\"Kolicina\") AS Naruceno" +
                " FROM \"Knjiga\", \"Narudzba\"" +
                " WHERE \"Knjiga\".\"ID\" = \"Narudzba\".\"vk_knjiga\"" +
                " GROUP BY 1" +
                " ORDER BY 2 DESC" +
                " LIMIT 5";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet skladisteDs = new DataSet();

            dataAdapter.Fill(skladisteDs);
            dgvTopNarudzbe.DataSource = skladisteDs.Tables[0];
            dgvTopNarudzbe.Columns[0].HeaderText = "Naslov knjige";
            dgvTopNarudzbe.Columns[0].Width = 210;
            dgvTopNarudzbe.Columns[1].HeaderText = "Naručena količina";
            dgvTopNarudzbe.Columns[1].Width = 72;
        }
        private void OsvjeziPodatke(NpgsqlConnection conn, int broj)
        {
            string upit =
                "SELECT \"Knjiga\".\"Naslov\", SUM(\"Narudzba\".\"Kolicina\") AS Naruceno" +
                " FROM \"Knjiga\", \"Narudzba\"" +
                " WHERE \"Knjiga\".\"ID\" = \"Narudzba\".\"vk_knjiga\"" +
                " GROUP BY 1" +
                " ORDER BY 2 DESC" +
                " LIMIT "+broj;

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet skladisteDs = new DataSet();

            dataAdapter.Fill(skladisteDs);
            dgvTopNarudzbe.DataSource = skladisteDs.Tables[0];
            dgvTopNarudzbe.Columns[0].HeaderText = "Naslov knjige";
            dgvTopNarudzbe.Columns[0].Width = 210;
            dgvTopNarudzbe.Columns[1].HeaderText = "Naručena količina";
            dgvTopNarudzbe.Columns[1].Width = 72;
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziPodatke(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
            txtTopBroj.Text = "5";
        }

        private void btnNazad_Click(object sender, EventArgs e)
        {
            ControlPanel frmControl = new ControlPanel();
            this.Hide();
            frmControl.ShowDialog();
            this.Close();
        }
    }
}
