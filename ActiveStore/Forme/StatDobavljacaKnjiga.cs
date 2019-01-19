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
    public partial class StatDobavljacaKnjiga : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public StatDobavljacaKnjiga()
        {
            InitializeComponent();
        }

        private void StatDobavljacaKnjiga_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziStatistiku(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void OsvjeziStatistiku(NpgsqlConnection conn)
        {
            chartUdioDobavljaca.Titles.Add("Udio pojedinog dobavljača u narudžbama");

            string upit =
                "SELECT \"Dobavljac\".\"Naziv\", SUM(\"Kolicina\") AS broj_knjiga " +
                " FROM \"Dobavljac\"" +
                " JOIN \"Narudzba\" ON \"Dobavljac\".\"ID\" = \"Narudzba\".\"vk_dobavljac\"" +
                " GROUP BY 1" +
                " ORDER BY 2 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet statDs = new DataSet();

            dataAdapter.Fill(statDs);
            chartUdioDobavljaca.DataSource = statDs.Tables[0];
            chartUdioDobavljaca.Series[0].XValueMember = "Naziv";
            chartUdioDobavljaca.Series[0].YValueMembers = "broj_knjiga";
            chartUdioDobavljaca.DataBind();

            dgvStatistika.DataSource = statDs.Tables[0];
            dgvStatistika.Columns[0].HeaderText = "Dobavljač";
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
