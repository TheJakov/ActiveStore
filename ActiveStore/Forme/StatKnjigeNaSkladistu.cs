using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;
using ActiveStore.Forme;
using ActiveStore.Klase;

namespace ActiveStore.Forme
{
    public partial class StatKnjigeNaSkladistu : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public StatKnjigeNaSkladistu()
        {
            InitializeComponent();
        }

        private void StatKnjigeNaSkladistu_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziStatistiku(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void OsvjeziStatistiku(NpgsqlConnection conn)
        {
            chartStatKnjigaNaSkladistu.Titles.Add("Udio knjiga na skladištu");

            string upit =
                "SELECT \"Knjiga\".\"Naslov\", \"Skladiste\".\"Kolicina\" "+
                " FROM \"Knjiga\", \"Skladiste\"" +
                " WHERE \"Knjiga\".\"ID\" = \"Skladiste\".\"ID_knjiga\"" +
                " ORDER BY 2";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet statDs = new DataSet();

            dataAdapter.Fill(statDs);
            chartStatKnjigaNaSkladistu.DataSource = statDs.Tables[0];
            chartStatKnjigaNaSkladistu.Series[0].XValueMember = "Naslov";
            chartStatKnjigaNaSkladistu.Series[0].YValueMembers = "Kolicina";
            chartStatKnjigaNaSkladistu.DataBind();

            dgvStatistika.DataSource = statDs.Tables[0];
            dgvStatistika.Columns[0].HeaderText = "Naslov knjige";
            dgvStatistika.Columns[0].Width = 150;
            dgvStatistika.Columns[1].HeaderText = "Količina";
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
