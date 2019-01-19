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
    public partial class StatZanrovaKnjiga : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public StatZanrovaKnjiga()
        {
            InitializeComponent();
        }

        private void StatZanrovaKnjiga_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziStatistiku(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void OsvjeziStatistiku(NpgsqlConnection conn)
        {
            chartUdioZanrova.Titles.Add("Udio pojedinog žanra knjige na skladištu");

            string upit =
                "SELECT \"Zanr\".\"Naziv\", COUNT(*) AS broj_knjiga " +
                " FROM \"Zanr\"" +
                " JOIN \"Knjiga\" ON \"Zanr\".\"ID\" = \"Knjiga\".\"vk_zanr\"" +
                " JOIN \"Skladiste\" ON \"Knjiga\".\"ID\"=\"Skladiste\".\"ID_knjiga\"" +
                " GROUP BY 1" +
                " ORDER BY 2 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet statDs = new DataSet();

            dataAdapter.Fill(statDs);
            chartUdioZanrova.DataSource = statDs.Tables[0];
            chartUdioZanrova.Series[0].XValueMember = "Naziv";
            chartUdioZanrova.Series[0].YValueMembers = "broj_knjiga";
            chartUdioZanrova.DataBind();

            dgvStatistika.DataSource = statDs.Tables[0];
            dgvStatistika.Columns[0].HeaderText = "Žanr";
            dgvStatistika.Columns[0].Width = 150;
            dgvStatistika.Columns[1].HeaderText = "Broj knjiga";
            dgvStatistika.Columns[1].Width = 70;
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
