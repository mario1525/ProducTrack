using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoProyecto : BaseDao<Proyecto>
    {
        public DaoProyecto(SqlClient dbContext) : base(dbContext)
        {
        }

        public async Task<List<Proyecto>> Gets(string Id)
        {
            const string procedureName = "dbo.dbSpProyectoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", Id),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<List<Proyecto>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpProyectoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async void Set(string operacion, Proyecto Proyecto)
        {
            if (Proyecto == null)
            {
                throw new ArgumentNullException(nameof(Proyecto));
            }

            string procedureName = "dbo.dbSpProyectoSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Proyecto.Id),
                new SqlParameter("@Nombre", Proyecto.Nombre),
                new SqlParameter("@IdCompania", Proyecto.IdCompania),
                new SqlParameter("@Descripcion", Proyecto.Descripcion),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpProyectoDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpProyectoActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        protected override List<Proyecto> MapDataTableToList(DataTable dataTable)
        {
            List<Proyecto> ProyectoList = new List<Proyecto>();
            foreach (DataRow row in dataTable.Rows)
            {
                Proyecto Proyecto = new Proyecto
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    IdCompania = row["IdCompania"].ToString(),
                    Descripcion = row["Descripcion"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = row["Fecha_log"].ToString(),
                    // Asigna otras propiedades según tu DataTable
                };
                ProyectoList.Add(Proyecto);
            }
            return ProyectoList;
        }
    }
}
