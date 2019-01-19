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
    public partial class StatAutoraKnjiga : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public StatAutoraKnjiga()
        {
            InitializeComponent();
        }

        private void StatAutoraKnjiga_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziStatistiku(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void OsvjeziStatistiku(NpgsqlConnection conn)
        {
            chartUdioAutora.Titles.Add("Udio pojedinog autora na skladištu");

            string upit =
                "SELECT \"Autor\".\"ImePrezime\", COUNT(*) AS broj_knjiga " +
                " FROM \"Autor\"" +
                " JOIN \"Knjiga\" ON \"Autor\".\"ID\" = \"Knjiga\".\"vk_autor\"" +
                " JOIN \"Skladiste\" ON \"Knjiga\".\"ID\"=\"Skladiste\".\"ID_knjiga\""+
                " GROUP BY 1" +
                " ORDER BY 2 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet statDs = new DataSet();

            dataAdapter.Fill(statDs);
            chartUdioAutora.DataSource = statDs.Tables[0];
            chartUdioAutora.Series[0].XValueMember = "ImePrezime";
            chartUdioAutora.Series[0].YValueMembers = "broj_knjiga";
            chartUdioAutora.DataBind();

            dgvStatistika.DataSource = statDs.Tables[0];
            dgvStatistika.Columns[0].HeaderText = "Autor";
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
