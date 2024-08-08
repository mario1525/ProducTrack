using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoLabCampVal : BaseDao<LabCampVal>
    {
        public DaoLabCampVal(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<LabCampVal>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpLabCampValGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Valor", ""),
                new SqlParameter("@IdLabCamp", ""),
                new SqlParameter("@IdRegisLabEtap", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<LabCampVal>> Gets()
        {
            const string procedureName = "dbo.dbSpLabCampValGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Valor", ""),
                new SqlParameter("@IdLabCamp", ""),
                new SqlParameter("@IdRegisLabEtap", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, LabCampVal labCampVal)
        {
            if (labCampVal == null)
            {
                throw new ArgumentNullException(nameof(labCampVal));
            }

            string procedureName = "dbo.dbSpLabCampValSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", labCampVal.Id),
                new SqlParameter("@Valor", labCampVal.Valor),
                new SqlParameter("@IdLabCamp", labCampVal.IdLabCamp),
                new SqlParameter("@IdRegisLabEtap", labCampVal.IdRegisLabEtap),
                new SqlParameter("@Estado", labCampVal.Estado),
                new SqlParameter("@Eliminado", labCampVal.Eliminado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpLabCampValDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpLabCampValActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de LabCampVal
        protected override List<LabCampVal> MapDataTableToList(DataTable dataTable)
        {
            List<LabCampVal> labCampValList = new List<LabCampVal>();
            foreach (DataRow row in dataTable.Rows)
            {
                LabCampVal labCampVal = new LabCampVal
                {
                    Id = row["Id"].ToString(),
                    Valor = row["Valor"].ToString(),
                    IdLabCamp = row["IdLabCamp"].ToString(),
                    IdRegisLabEtap = row["IdRegisLabEtap"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                labCampValList.Add(labCampVal);
            }
            return labCampValList;
        }
    }
}
