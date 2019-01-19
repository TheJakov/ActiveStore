using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;

namespace ActiveStore.Klase
{
    class Konekcija
    {
        public NpgsqlConnection conn;

        public void OtvoriKonekciju()
        {
            string connectionString = "Server=localhost;Port=5432;User Id=postgres;Password=jakov;Database=activeStore;";
            conn = new NpgsqlConnection(connectionString);
            conn.Open();
        }

        public void ZatvoriKonekciju()
        {
            conn.Close();
        }
    }
}
