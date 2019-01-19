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
    public partial class StatIzdavacaKnjiga : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public StatIzdavacaKnjiga()
        {
            InitializeComponent();
        }

        private void StatIzdavacaKnjiga_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziStatistiku(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void OsvjeziStatistiku(NpgsqlConnection conn)
        {
            chartUdioIzdavaca.Titles.Add("Udio pojedinog izdavača knjiga na skladištu");

            string upit =
                "SELECT \"Izdavac\".\"Naziv\", COUNT(*) AS broj_knjiga " +
                " FROM \"Izdavac\"" +
                " JOIN \"Knjiga\" ON \"Izdavac\".\"ID\" = \"Knjiga\".\"vk_izdavac\"" +
                " JOIN \"Skladiste\" ON \"Knjiga\".\"ID\"=\"Skladiste\".\"ID_knjiga\"" +
                " GROUP BY 1" +
                " ORDER BY 2 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet statDs = new DataSet();

            dataAdapter.Fill(statDs);
            chartUdioIzdavaca.DataSource = statDs.Tables[0];
            chartUdioIzdavaca.Series[0].XValueMember = "Naziv";
            chartUdioIzdavaca.Series[0].YValueMembers = "broj_knjiga";
            chartUdioIzdavaca.DataBind();

            dgvStatistika.DataSource = statDs.Tables[0];
            dgvStatistika.Columns[0].HeaderText = "Izdavač";
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
