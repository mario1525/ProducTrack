using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoArchivoVal : BaseDao<ArchivoVal>
    {
        public DaoArchivoVal(SqlClient dbContext) : base(dbContext)
        {
        }

        // Método Get
        public async Task<List<ArchivoVal>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpArchivoValGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre_Archivo", ""),
                new SqlParameter("@Extension", ""),
                new SqlParameter("@Formato", ""),
                new SqlParameter("@Archivos", ""),
                new SqlParameter("@Tamanio", 0),
                new SqlParameter("@IdArchivo", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Método Gets
        public async Task<List<ArchivoVal>> Gets()
        {
            const string procedureName = "dbo.dbSpArchivoValGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre_Archivo", ""),
                new SqlParameter("@Extension", ""),
                new SqlParameter("@Formato", ""),
                new SqlParameter("@Archivos", ""),
                new SqlParameter("@Tamanio", 0),
                new SqlParameter("@IdArchivo", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Método Set
        public async void Set(string operacion, ArchivoVal archivoVal)
        {
            if (archivoVal == null)
            {
                throw new ArgumentNullException(nameof(archivoVal));
            }

            string procedureName = "dbo.dbSpArchivoValSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", archivoVal.Id),
                new SqlParameter("@Nombre_Archivo", archivoVal.Nombre_Archivo),
                new SqlParameter("@Extension", archivoVal.Extension),
                new SqlParameter("@Formato", archivoVal.Formato),
                new SqlParameter("@Archivos", archivoVal.Archivos),
                new SqlParameter("@Tamanio", archivoVal.Tamanio),
                new SqlParameter("@IdArchivo", archivoVal.IdArchivo),
                new SqlParameter("@Estado", archivoVal.Estado),
                new SqlParameter("@Eliminado", ""),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Método Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpArchivoValDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Método para mapear DataTable a una lista de ArchivoVal
        protected override List<ArchivoVal> MapDataTableToList(DataTable dataTable)
        {
            List<ArchivoVal> archivoValList = new List<ArchivoVal>();
            foreach (DataRow row in dataTable.Rows)
            {
                ArchivoVal archivoVal = new ArchivoVal
                {
                    Id = row["Id"].ToString(),
                    Nombre_Archivo = row["Nombre_Archivo"].ToString(),
                    Extension = row["Extension"].ToString(),
                    Formato = row["Formato"].ToString(),
                    Archivos = GetFileBytes(row["Archivos"]),
                    Tamanio = Convert.ToDouble(row["Tamanio"]),
                    IdArchivo = row["IdArchivo"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                archivoValList.Add(archivoVal);
            }
            return archivoValList;
        }

        // Método para obtener bytes de un archivo
        private byte[] GetFileBytes(object fileObject)
        {
            if (fileObject == null || fileObject == DBNull.Value)
                return null;

            if (fileObject is byte[] fileBytes)
                return fileBytes;

            // Handle conversion from other types if necessary
            throw new InvalidCastException("Unable to convert file object to byte array.");
        }
    }
}
