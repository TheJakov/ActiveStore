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
    public partial class Narudzbe : Form
    {
        Konekcija mojaKonekcija = new Konekcija();
        public Narudzbe()
        {
            InitializeComponent();
        }

        private void Narudzbe_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziNarudzbe(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void OsvjeziNarudzbe(NpgsqlConnection conn)
        {
            string upit = "SELECT \"Narudzba\".\"ID\", \"Knjiga\".\"Naslov\", \"Dobavljac\".\"Naziv\", \"Narudzba\"" +
                ".\"Kolicina\", \"Narudzba\".\"Datum_nastanka\", \"Narudzba\".\"Datum_zaprimanja\" " +
                "FROM \"Knjiga\" " +
                "JOIN \"Narudzba\" ON \"Knjiga\".\"ID\" = \"Narudzba\".\"vk_knjiga\" " +
                "JOIN \"Dobavljac\" ON \"Narudzba\".\"vk_dobavljac\" = \"Dobavljac\".\"ID\" " +
                "ORDER BY 1 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet narudzbeDs = new DataSet();

            dataAdapter.Fill(narudzbeDs);
            dgvNarudzbe.DataSource = narudzbeDs.Tables[0];
            dgvNarudzbe.Columns[0].HeaderText = "Redni broj";
            dgvNarudzbe.Columns[0].Width = 64;
            dgvNarudzbe.Columns[1].HeaderText = "Naslov knjige";
            dgvNarudzbe.Columns[1].Width = 184;
            dgvNarudzbe.Columns[2].HeaderText = "Naziv dobavljača";
            dgvNarudzbe.Columns[2].Width = 120;
            dgvNarudzbe.Columns[3].HeaderText = "Količina";
            dgvNarudzbe.Columns[3].Width = 70;
            dgvNarudzbe.Columns[4].HeaderText = "Izrađeno";
            dgvNarudzbe.Columns[4].Width = 95;
            dgvNarudzbe.Columns[5].HeaderText = "Zaprimljeno";
            dgvNarudzbe.Columns[5].Width = 95;
        }

        private void btnNazad_Click(object sender, EventArgs e)
        {
            ControlPanel frmControl = new ControlPanel();
            this.Hide();
            frmControl.ShowDialog();
            this.Close();
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            txtNaslovKnjige.Clear();
            txtNazivDobavljaca.Clear();
            dateIzradene.Value = DateTime.Now;
            dateZaprimljene.Value = DateTime.Now;

            mojaKonekcija.OtvoriKonekciju();
            OsvjeziNarudzbe(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void txtNaslovKnjige_TextChanged(object sender, EventArgs e)
        {
            txtNazivDobavljaca.Clear();
            string upit = "SELECT \"Narudzba\".\"ID\", \"Knjiga\".\"Naslov\", \"Dobavljac\".\"Naziv\", \"Narudzba\"" +
                ".\"Kolicina\", \"Narudzba\".\"Datum_nastanka\", \"Narudzba\".\"Datum_zaprimanja\" " +
                "FROM \"Knjiga\" " +
                "JOIN \"Narudzba\" ON \"Knjiga\".\"ID\" = \"Narudzba\".\"vk_knjiga\" " +
                "JOIN \"Dobavljac\" ON \"Narudzba\".\"vk_dobavljac\" = \"Dobavljac\".\"ID\" " +
                "WHERE \"Knjiga\".\"Naslov\" LIKE '" + txtNaslovKnjige.Text + "%' "+
                "ORDER BY 1 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, mojaKonekcija.conn);
            DataSet narudzbeDs = new DataSet();

            dataAdapter.Fill(narudzbeDs);
            dgvNarudzbe.DataSource = narudzbeDs.Tables[0];
            dgvNarudzbe.Columns[0].HeaderText = "Redni broj";
            dgvNarudzbe.Columns[0].Width = 64;
            dgvNarudzbe.Columns[1].HeaderText = "Naslov knjige";
            dgvNarudzbe.Columns[1].Width = 184;
            dgvNarudzbe.Columns[2].HeaderText = "Naziv dobavljača";
            dgvNarudzbe.Columns[2].Width = 120;
            dgvNarudzbe.Columns[3].HeaderText = "Količina";
            dgvNarudzbe.Columns[3].Width = 70;
            dgvNarudzbe.Columns[4].HeaderText = "Izrađeno";
            dgvNarudzbe.Columns[4].Width = 95;
            dgvNarudzbe.Columns[5].HeaderText = "Zaprimljeno";
            dgvNarudzbe.Columns[5].Width = 95;
        }

        private void txtNazivDobavljaca_TextChanged(object sender, EventArgs e)
        {
            txtNaslovKnjige.Clear();
            string upit = "SELECT \"Narudzba\".\"ID\", \"Knjiga\".\"Naslov\", \"Dobavljac\".\"Naziv\", \"Narudzba\"" +
                ".\"Kolicina\", \"Narudzba\".\"Datum_nastanka\", \"Narudzba\".\"Datum_zaprimanja\" " +
                "FROM \"Knjiga\" " +
                "JOIN \"Narudzba\" ON \"Knjiga\".\"ID\" = \"Narudzba\".\"vk_knjiga\" " +
                "JOIN \"Dobavljac\" ON \"Narudzba\".\"vk_dobavljac\" = \"Dobavljac\".\"ID\" " +
                "WHERE \"Dobavljac\".\"Naziv\" LIKE '" + txtNazivDobavljaca.Text + "%' " +
                "ORDER BY 1 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, mojaKonekcija.conn);
            DataSet narudzbeDs = new DataSet();

            dataAdapter.Fill(narudzbeDs);
            dgvNarudzbe.DataSource = narudzbeDs.Tables[0];
            dgvNarudzbe.Columns[0].HeaderText = "Redni broj";
            dgvNarudzbe.Columns[0].Width = 64;
            dgvNarudzbe.Columns[1].HeaderText = "Naslov knjige";
            dgvNarudzbe.Columns[1].Width = 184;
            dgvNarudzbe.Columns[2].HeaderText = "Naziv dobavljača";
            dgvNarudzbe.Columns[2].Width = 120;
            dgvNarudzbe.Columns[3].HeaderText = "Količina";
            dgvNarudzbe.Columns[3].Width = 70;
            dgvNarudzbe.Columns[4].HeaderText = "Izrađeno";
            dgvNarudzbe.Columns[4].Width = 95;
            dgvNarudzbe.Columns[5].HeaderText = "Zaprimljeno";
            dgvNarudzbe.Columns[5].Width = 95;
        }

        private void dateIzradene_ValueChanged(object sender, EventArgs e)
        {
            PretraziPoDatumuNastanka(dateIzradene.Value.Date);
        }

        private void dateZaprimljene_ValueChanged(object sender, EventArgs e)
        {
            PretraziPoDatumuZaprimanja(dateZaprimljene.Value.Date);
        }

        private void PretraziPoDatumuNastanka(DateTime date)
        {
            txtNaslovKnjige.Clear();
            txtNazivDobavljaca.Clear();

            string upit = "SELECT \"Narudzba\".\"ID\", \"Knjiga\".\"Naslov\", \"Dobavljac\".\"Naziv\", \"Narudzba\"" +
                ".\"Kolicina\", \"Narudzba\".\"Datum_nastanka\", \"Narudzba\".\"Datum_zaprimanja\" " +
                "FROM \"Knjiga\" " +
                "JOIN \"Narudzba\" ON \"Knjiga\".\"ID\" = \"Narudzba\".\"vk_knjiga\" " +
                "JOIN \"Dobavljac\" ON \"Narudzba\".\"vk_dobavljac\" = \"Dobavljac\".\"ID\" " +
                "WHERE \"Narudzba\".\"Datum_nastanka\" >= '" + date.Date + "' AND " +
                "\"Narudzba\".\"Datum_nastanka\" < '" + date.Date.AddDays(1) + "'" +
                "ORDER BY 1 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, mojaKonekcija.conn);
            DataSet narudzbeDs = new DataSet();

            dataAdapter.Fill(narudzbeDs);
            dgvNarudzbe.DataSource = narudzbeDs.Tables[0];
            dgvNarudzbe.Columns[0].HeaderText = "Redni broj";
            dgvNarudzbe.Columns[0].Width = 64;
            dgvNarudzbe.Columns[1].HeaderText = "Naslov knjige";
            dgvNarudzbe.Columns[1].Width = 184;
            dgvNarudzbe.Columns[2].HeaderText = "Naziv dobavljača";
            dgvNarudzbe.Columns[2].Width = 120;
            dgvNarudzbe.Columns[3].HeaderText = "Količina";
            dgvNarudzbe.Columns[3].Width = 70;
            dgvNarudzbe.Columns[4].HeaderText = "Izrađeno";
            dgvNarudzbe.Columns[4].Width = 95;
            dgvNarudzbe.Columns[5].HeaderText = "Zaprimljeno";
            dgvNarudzbe.Columns[5].Width = 95;
        }

        private void PretraziPoDatumuZaprimanja(DateTime date)
        {
            txtNaslovKnjige.Clear();
            txtNazivDobavljaca.Clear();

            string upit = "SELECT \"Narudzba\".\"ID\", \"Knjiga\".\"Naslov\", \"Dobavljac\".\"Naziv\", \"Narudzba\"" +
                ".\"Kolicina\", \"Narudzba\".\"Datum_nastanka\", \"Narudzba\".\"Datum_zaprimanja\" " +
                "FROM \"Knjiga\" " +
                "JOIN \"Narudzba\" ON \"Knjiga\".\"ID\" = \"Narudzba\".\"vk_knjiga\" " +
                "JOIN \"Dobavljac\" ON \"Narudzba\".\"vk_dobavljac\" = \"Dobavljac\".\"ID\" " +
                "WHERE \"Narudzba\".\"Datum_zaprimanja\" >= '" + date.Date + "' AND " +
                "\"Narudzba\".\"Datum_zaprimanja\" < '" + date.Date.AddDays(1) + "'" +
                "ORDER BY 1 DESC";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, mojaKonekcija.conn);
            DataSet narudzbeDs = new DataSet();

            dataAdapter.Fill(narudzbeDs);
            dgvNarudzbe.DataSource = narudzbeDs.Tables[0];
            dgvNarudzbe.Columns[0].HeaderText = "Redni broj";
            dgvNarudzbe.Columns[0].Width = 64;
            dgvNarudzbe.Columns[1].HeaderText = "Naslov knjige";
            dgvNarudzbe.Columns[1].Width = 184;
            dgvNarudzbe.Columns[2].HeaderText = "Naziv dobavljača";
            dgvNarudzbe.Columns[2].Width = 120;
            dgvNarudzbe.Columns[3].HeaderText = "Količina";
            dgvNarudzbe.Columns[3].Width = 70;
            dgvNarudzbe.Columns[4].HeaderText = "Izrađeno";
            dgvNarudzbe.Columns[4].Width = 95;
            dgvNarudzbe.Columns[5].HeaderText = "Zaprimljeno";
            dgvNarudzbe.Columns[5].Width = 95;
        }
    }
}
