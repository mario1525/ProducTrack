using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoCompania
    {
        #region Metodos 

        private readonly SqlClient _sqlClient;

        public DaoCompania(SqlClient dbContext)
        {
            _sqlClient = dbContext;
        }        

        // metodo get 
        public async Task<DataTable> GetCompania(Compania compania)
        {
            try
            {
                // Nombre del procedimiento almacenado
                const string procedureName = "dbo.dbSpCompaniaGet";

                // Definición de parámetros
                var parameters = new[]
                {
                new SqlParameter("@Id", compania.Id),
                new SqlParameter("@Nombre", compania.Nombre),
                new SqlParameter("@NIT", compania.NIT),
                new SqlParameter("@Direccion", compania.Direccion),                
                new SqlParameter("@Estado", 1)
                };

                // Ejecutar el procedimiento almacenado
                DataTable dataTable = await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);

                return dataTable;
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al obtener companias: {ex.Message}");
                throw;
            }
        }

        // Metodo Set 
        public async void SetCompania(string operacion, Compania compania)
        {
            try
            {

                if (compania == null)
                {
                    throw new ArgumentNullException(nameof(compania));
                }

                string procedureName = "dbo.dbSpCompaniaSet";
                SqlParameter[] parameters =
                {
                    new SqlParameter("@Id", compania.Id),
                    new SqlParameter("@Nombre", compania.Nombre),
                    new SqlParameter("@NIT", compania.NIT),
                    new SqlParameter("@Direccion", compania.Direccion),
                    new SqlParameter("@Estado", 1),
                    new SqlParameter("@Operacion", operacion),
               };
                await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
                // _sqlClient.
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al crear/modificar una compania: {ex.Message}");
                throw;
            }
        }

        // Metodo Delete
        public async Task<DataTable> DeleteCompania(string Id)
        {
            try
            {


                string procedureName = "dbo.dbSpCompaniaDel";
                SqlParameter[] parameters =
                {
                    new SqlParameter("@Id", Id)
                };
                return await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al eliminar una compania: {ex.Message}");
                throw;
            }

        }

        // Metodo Active        
        public async Task<DataTable> ActiveCompania(string Id, int estado)
        {
            try
            {
                string procedureName = "dbo.dbSpCompaniaActive";
                SqlParameter[] parameters =
                {
                    new SqlParameter("@Id", Id),
                    new SqlParameter("@Estado", estado)
                };
                return await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al carbiar el estado de la compania: {ex.Message}");
                throw;
            }
        }
        #endregion
    }
}
