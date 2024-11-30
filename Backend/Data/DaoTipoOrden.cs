using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoTipoOrden : BaseDao<TipoOrden>
    {
        public DaoTipoOrden(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<TipoOrden>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpTipoOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdProyecto", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<TipoOrden>> Gets(string IdProyecto)
        {
            const string procedureName = "dbo.dbSpTipoOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdProyecto", IdProyecto),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, TipoOrden TipoOrden)
        {
            if (TipoOrden == null)
            {
                throw new ArgumentNullException(nameof(TipoOrden));
            }


            string procedureName = "dbo.dbSpTipoOrdenSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", TipoOrden.Id),
                new SqlParameter("@Nombre", TipoOrden.Nombre),
                new SqlParameter("@Descripcion", TipoOrden.Descripcion),
                new SqlParameter("@IdProyecto", TipoOrden.IdProyecto),
                new SqlParameter("@Estado", TipoOrden.Estado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpTipoOrdenDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpTipoOrdenActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de Orden
        protected override List<TipoOrden> MapDataTableToList(DataTable dataTable)
        {
            List<TipoOrden> ordenList = new List<TipoOrden>();
            foreach (DataRow row in dataTable.Rows)
            {
                TipoOrden orden = new TipoOrden
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    Descripcion = row["Descripcion"].ToString(),
                    IdProyecto = row["IdProyecto"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    //Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = row["Fecha_log"].ToString(),
                };
                ordenList.Add(orden);
            }
            return ordenList;
        }
    }
}
