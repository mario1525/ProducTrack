using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoRegisOrden : BaseDao<RegisOrden>
    {
        public DaoRegisOrden(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<RegisOrden>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpRegisOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@IdRegisOrden", Id),
                new SqlParameter("@IdOrden", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<RegisOrden>> GetsUser(string IdUsuario)
        {
            const string procedureName = "dbo.dbSpRegisOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@IdRegisOrden", ""),
                new SqlParameter("@IdOrden", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdUsuario", IdUsuario),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<RegisOrden>> Gets(string IdCompania)
        {            
            const string procedureName = "dbo.dbSpRegisOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@IdRegisOrden", ""),
                new SqlParameter("@IdOrden", ""),
                new SqlParameter("@IdCompania", IdCompania),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion,string idOrdenProcesEtap, CreateRegisOrden Orden)
        {
            if (Orden == null)
            {
                throw new ArgumentNullException(nameof(Orden));
            }

            DataTable camposTable = new DataTable();
            camposTable.Columns.Add("id", typeof(string));
            camposTable.Columns.Add("valor", typeof(string));
            camposTable.Columns.Add("idOrdenCamp", typeof(string));

            // Recorrer el array de campos y agregar cada campo como una fila al DataTable
            foreach (var campo in Orden.Campos)
            {
                camposTable.Rows.Add(campo.Id, campo.Valor, campo.IdOrdenCamp);
            }

            string procedureName = "dbo.dbSpRegisOrdenSetPrueba";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Orden.Orden.Id),
                new SqlParameter("@IdOrden", Orden.Orden.IdOrden),
                new SqlParameter("@IdCompania", Orden.Orden.IdCompania),
                new SqlParameter("@IdUsuario", Orden.Orden.IdUsuario),
                new SqlParameter("@Estado", Orden.Orden.Estado),
                new SqlParameter("@IdRegisOrdenEtap", idOrdenProcesEtap),
                new SqlParameter
                    {
                        ParameterName = "@campos",
                        SqlDbType = SqlDbType.Structured,
                        Value = camposTable // Pasar el DataTable como parámetro
                    },
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpRegisOrdenDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpRegisOrdenActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de RegisOrden
        protected override List<RegisOrden> MapDataTableToList(DataTable dataTable)
        {
            List<RegisOrden> regisOrdenList = new List<RegisOrden>();
            foreach (DataRow row in dataTable.Rows)
            {
                RegisOrden regisOrden = new RegisOrden
                {
                    Id = row["Id"].ToString(),
                    IdOrden = row["IdOrden"].ToString(),
                    IdCompania = row["IdCompania"].ToString(),
                    IdUsuario = row["IdUsuario"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = row["Fecha_log"].ToString()
                };
                regisOrdenList.Add(regisOrden);
            }
            return regisOrdenList;
        }
    }
}
