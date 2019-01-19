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
using ActiveStore.Klase;
using ActiveStore.Forme;

namespace ActiveStore
{
    public partial class ControlPanel : Form
    {
        Konekcija mojaKonekcija = new Konekcija();

        private int odabranaKnjiga;
        private bool simulacijaPokrenuta = false;
        public ControlPanel()
        {
            InitializeComponent();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            mojaKonekcija.OtvoriKonekciju();
            OsvjeziPodatke(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }

        private void OsvjeziPodatke(NpgsqlConnection conn)
        {
            string upit = 
                "SELECT \"Skladiste\".\"ID_knjiga\", \"Knjiga\".\"Naslov\", \"Skladiste\".\"Kolicina\"," +
                " \"Skladiste\".\"Posljednja_promjena\"" +
                " FROM \"Skladiste\", \"Knjiga\"" +
                " WHERE \"Skladiste\".\"ID_knjiga\" = \"Knjiga\".\"ID\"" +
                " ORDER BY 1";

            NpgsqlDataAdapter dataAdapter = new NpgsqlDataAdapter(upit, conn);
            DataSet skladisteDs = new DataSet();

            dataAdapter.Fill(skladisteDs);
            dgvSkladiste.DataSource = skladisteDs.Tables[0];
            dgvSkladiste.Columns[0].HeaderText = "Šifra knjige";
            dgvSkladiste.Columns[0].Width = 48;
            dgvSkladiste.Columns[1].HeaderText = "Naslov";
            dgvSkladiste.Columns[1].Width = 104;
            dgvSkladiste.Columns[2].HeaderText = "Količina na skladištu";
            dgvSkladiste.Columns[2].Width = 63;
            dgvSkladiste.Columns[3].HeaderText = "Posljednja promjena stanja";
            dgvSkladiste.Columns[3].Width = 96;
        }

        private void btnDodajJedan_Click(object sender, EventArgs e)
        {
            DodajKolicinu(1);
        }
        private void btnDodajPet_Click(object sender, EventArgs e)
        {
            DodajKolicinu(5);
        }

        private void btnDodajN_Click(object sender, EventArgs e)
        {
            if (odabranaKnjiga != 0)
            {
                if (txtDodajN.Text == "")
                {
                    MessageBox.Show("Morate prvo unjeti broj !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    int broj;
                    int.TryParse(txtDodajN.Text, out broj);
                    if (broj > 0)
                    {
                        mojaKonekcija.OtvoriKonekciju();
                        string sql = "UPDATE \"Skladiste\" SET \"Kolicina\"=\"Kolicina\"+"+broj+" WHERE \"ID_knjiga\"=" + odabranaKnjiga + ";";
                        NpgsqlCommand command = new NpgsqlCommand(sql, mojaKonekcija.conn);
                        command.ExecuteNonQuery();
                        OsvjeziPodatke(mojaKonekcija.conn);
                        mojaKonekcija.ZatvoriKonekciju();
                        txtDodajN.Clear();
                    }
                    else
                    {
                        MessageBox.Show("Morate unjeti pozitivan cijeli broj !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        txtDodajN.Clear();
                    }
                } 
            }
            else
            {
                MessageBox.Show("Morate prvo odabrati knjigu !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void flatButtonRed1_Click(object sender, EventArgs e)
        {
            OduzmiKolicinu(1);
        }

        private void btnOduzmiPet_Click(object sender, EventArgs e)
        {
            OduzmiKolicinu(5);
        }
        private void btnOduzmiN_Click(object sender, EventArgs e)
        {
            if (odabranaKnjiga != 0)
            {
                if (txtOduzmiN.Text == "")
                {
                    MessageBox.Show("Morate prvo unjeti broj !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    int broj;
                    int.TryParse(txtOduzmiN.Text, out broj);
                    if (broj > 0)
                    {
                        mojaKonekcija.OtvoriKonekciju();
                        string sql = "UPDATE \"Skladiste\" SET \"Kolicina\"=\"Kolicina\"-" + broj + " WHERE \"ID_knjiga\"=" + odabranaKnjiga + ";";
                        NpgsqlCommand command = new NpgsqlCommand(sql, mojaKonekcija.conn);
                        try
                        {
                            command.ExecuteNonQuery();
                        }
                        catch (NpgsqlException ex)
                        {
                            MessageBox.Show(ex.Message, "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        }
                        OsvjeziPodatke(mojaKonekcija.conn);
                        mojaKonekcija.ZatvoriKonekciju();
                        txtOduzmiN.Clear();
                    }
                    else
                    {
                        MessageBox.Show("Morate unjeti pozitivan cijeli broj !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        txtOduzmiN.Clear();
                    }
                }
            }
            else
            {
                MessageBox.Show("Morate prvo odabrati knjigu !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void dgvSkladiste_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                odabranaKnjiga = int.Parse(dgvSkladiste.CurrentRow.Cells[0].Value.ToString());
            }
            catch (Exception) {
                odabranaKnjiga = 0;
            }
        }

        private void btnUgasi_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void DodajKolicinu(int broj)
        {
            if (odabranaKnjiga != 0)
            {
                mojaKonekcija.OtvoriKonekciju();
                string sql = "UPDATE \"Skladiste\" SET \"Kolicina\"=\"Kolicina\"+"+broj+" WHERE \"ID_knjiga\"=" + odabranaKnjiga + ";";
                NpgsqlCommand command = new NpgsqlCommand(sql, mojaKonekcija.conn);
                command.ExecuteNonQuery();
                OsvjeziPodatke(mojaKonekcija.conn);
                mojaKonekcija.ZatvoriKonekciju();
            }
            else
            {
                MessageBox.Show("Morate prvo odabrati knjigu !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void OduzmiKolicinu(int broj)
        {
            if (odabranaKnjiga != 0)
            {
                mojaKonekcija.OtvoriKonekciju();
                string sql = "UPDATE \"Skladiste\" SET \"Kolicina\"=\"Kolicina\"-" + broj + " WHERE \"ID_knjiga\"=" + odabranaKnjiga + ";";
                NpgsqlCommand command = new NpgsqlCommand(sql, mojaKonekcija.conn);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (NpgsqlException ex)
                {
                    MessageBox.Show(ex.Message, "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
                OsvjeziPodatke(mojaKonekcija.conn);
                mojaKonekcija.ZatvoriKonekciju();
            }
            else
            {
                MessageBox.Show("Morate prvo odabrati knjigu !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnDnevnik_Click(object sender, EventArgs e)
        {
            Dnevnik frmDnevnik = new Dnevnik();
            this.Hide();
            frmDnevnik.ShowDialog();
            this.Close();
        }

        private void btnStatKnjigeNaSkladistu_Click(object sender, EventArgs e)
        {
            StatKnjigeNaSkladistu frmStatKnjigaNaSkladistu = new StatKnjigeNaSkladistu();
            this.Hide();
            frmStatKnjigaNaSkladistu.ShowDialog();
            this.Close();
        }

        private void btnTopXNarudzbe_Click(object sender, EventArgs e)
        {
            StatTopXNarudzbe frmTopX = new StatTopXNarudzbe();
            this.Hide();
            frmTopX.ShowDialog();
            this.Close();
        }

        private void btnUdioAutor_Click(object sender, EventArgs e)
        {
            StatAutoraKnjiga frmStatAutor = new StatAutoraKnjiga();
            this.Hide();
            frmStatAutor.ShowDialog();
            this.Close();
        }

        private void btnStatistikaZanrovi_Click(object sender, EventArgs e)
        {
            StatZanrovaKnjiga frmStatZanr = new StatZanrovaKnjiga();
            this.Hide();
            frmStatZanr.ShowDialog();
            this.Close();
        }

        private void btnStatistikaIzdavaca_Click(object sender, EventArgs e)
        {
            StatIzdavacaKnjiga frmStatIzdavaca = new StatIzdavacaKnjiga();
            this.Hide();
            frmStatIzdavaca.ShowDialog();
            this.Close();
        }

        private void btnStatDobavljaca_Click(object sender, EventArgs e)
        {
            StatDobavljacaKnjiga frmStatDobavljaca = new StatDobavljacaKnjiga();
            this.Hide();
            frmStatDobavljaca.ShowDialog();
            this.Close();
        }

        private void btnNarudzbe_Click(object sender, EventArgs e)
        {
            Narudzbe frmNarudzbe = new Narudzbe();
            this.Hide();
            frmNarudzbe.ShowDialog();
            this.Close();
        }

        private void btnPokreni_Click(object sender, EventArgs e)
        {
            if (simulacijaPokrenuta == false)
            {
                if (txtInterval.Text.Length > 0)
                {
                    if (int.TryParse(txtInterval.Text, out int interval) && interval > 0)
                    {
                        simulacijaPokrenuta = true;
                        simulacijaTimer.Interval = interval * 1000;
                        simulacijaTimer.Start();

                        btnPokreni.Text = "ZAUSTAVI";
                        panelStatus.BackColor = Color.Lime;
                        labelStatus.Text = "Pokrenuto";
                    }
                    else
                    {
                        MessageBox.Show("Interval mora biti pozitivan cijeli broj !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        txtInterval.Clear();
                    }
                }
                else
                {
                    MessageBox.Show("Niste unjeli interval u sekundama !", "Pažnja", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtInterval.Clear();
                }
            }
            else //simulacija je već pokrenuta
            {
                simulacijaTimer.Stop();
                simulacijaTimer.Interval = 10000;

                simulacijaPokrenuta = false;
                btnPokreni.Text = "POKRENI";
                panelStatus.BackColor = Color.Red;
                labelStatus.Text = "Zaustavljeno";
                txtInterval.Clear();
            }
            

        }

        private void Simulacija()
        {
            Random randomHelper = new Random();

            int randomKolicina = randomHelper.Next(1,10);
            int randomKnjiga = randomHelper.Next(1, 22);

            SimuliranoOduzimanje(randomKnjiga, randomKolicina);
        }

        private void simulacijaTimer_Tick(object sender, EventArgs e)
        {
            Simulacija();
        }

        private void SimuliranoOduzimanje(int idKnjiga, int kolicina)
        {
            mojaKonekcija.OtvoriKonekciju();
            string sql = "UPDATE \"Skladiste\" SET \"Kolicina\"=\"Kolicina\"-" + kolicina + " WHERE \"ID_knjiga\"=" + idKnjiga + ";";
            NpgsqlCommand command = new NpgsqlCommand(sql, mojaKonekcija.conn);
            try
            {
                command.ExecuteNonQuery();
            }
            catch (NpgsqlException ex)
            {
                MessageBox.Show(ex.Message, "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            OsvjeziPodatke(mojaKonekcija.conn);
            mojaKonekcija.ZatvoriKonekciju();
        }
    }
}
