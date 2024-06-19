using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoLab : BaseDao<Lab>
    {
        public DaoLab(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<Lab>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpLabGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<Lab>> Gets()
        {
            const string procedureName = "dbo.dbSpLabGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, Lab lab)
        {
            if (lab == null)
            {
                throw new ArgumentNullException(nameof(lab));
            }

            string procedureName = "dbo.dbSpLabSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", lab.Id),
                new SqlParameter("@Nombre", lab.Nombre),
                new SqlParameter("@IdCompania", lab.IdCompania),
                new SqlParameter("@Estado", lab.Estado),
                new SqlParameter("@Eliminado", lab.Eliminado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpLabDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpLabActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de Lab
        protected override List<Lab> MapDataTableToList(DataTable dataTable)
        {
            List<Lab> labList = new List<Lab>();
            foreach (DataRow row in dataTable.Rows)
            {
                Lab lab = new Lab
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    IdCompania = row["IdCompania"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                labList.Add(lab);
            }
            return labList;
        }
    }
}
