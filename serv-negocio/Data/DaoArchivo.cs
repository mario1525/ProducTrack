using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoArchivo : BaseDao<Archivo>
    {
        public DaoArchivo(SqlClient dbContext) : base(dbContext)
        {
        }

        // Método Get
        public async Task<List<Archivo>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpArchivoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoArchv", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Método Gets
        public async Task<List<Archivo>> Gets()
        {
            const string procedureName = "dbo.dbSpArchivoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoArchv", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Método Set
        public async void Set(string operacion, Archivo archivo)
        {
            if (archivo == null)
            {
                throw new ArgumentNullException(nameof(archivo));
            }

            string procedureName = "dbo.dbSpArchivoSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", archivo.Id),
                new SqlParameter("@Nombre", archivo.Nombre),
                new SqlParameter("@TipoArchv", archivo.TipoArchv),
                new SqlParameter("@IdCompania", archivo.IdCompania),
                new SqlParameter("@Estado", archivo.Estado),
                new SqlParameter("@Eliminado", ""),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Método Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpArchivoDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Método Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpArchivoActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Método para mapear DataTable a una lista de Archivo
        protected override List<Archivo> MapDataTableToList(DataTable dataTable)
        {
            List<Archivo> archivoList = new List<Archivo>();
            foreach (DataRow row in dataTable.Rows)
            {
                Archivo archivo = new Archivo
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    TipoArchv = row["TipoArchv"].ToString(),
                    IdCompania = row["IdCompania"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                archivoList.Add(archivo);
            }
            return archivoList;
        }
    }
}
