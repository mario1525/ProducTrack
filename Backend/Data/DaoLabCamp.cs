using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoLabCamp : BaseDao<LabCamp>
    {
        public DaoLabCamp(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<LabCamp>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpLabCampGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoDato", ""),
                new SqlParameter("@UnidadMedida", ""),
                new SqlParameter("@Obligatorio", 0),
                new SqlParameter("@IdLab", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<LabCamp>> Gets()
        {
            const string procedureName = "dbo.dbSpLabCampGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoDato", ""),
                new SqlParameter("@UnidadMedida", ""),
                new SqlParameter("@Obligatorio", 0),
                new SqlParameter("@IdLab", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, LabCamp labCamp)
        {
            if (labCamp == null)
            {
                throw new ArgumentNullException(nameof(labCamp));
            }

            string procedureName = "dbo.dbSpLabCampSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", labCamp.Id),
                new SqlParameter("@Nombre", labCamp.Nombre),
                new SqlParameter("@TipoDato", labCamp.TipoDato),
                new SqlParameter("@UnidadMedida", labCamp.UnidadMedida),
                new SqlParameter("@Obligatorio", labCamp.Obligatorio),
                new SqlParameter("@IdLab", labCamp.IdLab),
                new SqlParameter("@Estado", labCamp.Estado),
                new SqlParameter("@Eliminado", labCamp.Eliminado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpLabCampDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpLabCampActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de LabCamp
        protected override List<LabCamp> MapDataTableToList(DataTable dataTable)
        {
            List<LabCamp> labCampList = new List<LabCamp>();
            foreach (DataRow row in dataTable.Rows)
            {
                LabCamp labCamp = new LabCamp
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    TipoDato = row["TipoDato"].ToString(),
                    UnidadMedida = row["UnidadMedida"].ToString(),
                    Obligatorio = Convert.ToBoolean(row["Obligatorio"]),
                    IdLab = row["IdLab"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                labCampList.Add(labCamp);
            }
            return labCampList;
        }
    }
}
