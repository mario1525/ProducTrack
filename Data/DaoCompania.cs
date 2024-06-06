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
        public async Task<DataTable> GetUsers(Usuario user)
        {
            try
            {
                // Nombre del procedimiento almacenado
                const string procedureName = "dbo.dbSpUsuarioGet";

                // Definición de parámetros
                var parameters = new[]
                {
                new SqlParameter("@Id", user.Id),
                new SqlParameter("@Nombre", user.Nombre),
                new SqlParameter("@Apellido", user.Apellido),
                new SqlParameter("@Correo", user.Correo),
                new SqlParameter("@IdCompania", user.IdCompania),
                new SqlParameter("@Cargo", user.Cargo),
                new SqlParameter("@Rol", user.Rol),
                new SqlParameter("@Estado", 1)
                };

                // Ejecutar el procedimiento almacenado
                DataTable dataTable = await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);

                return dataTable;
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al obtener usuarios: {ex.Message}");
                throw;
            }
        }

        // Metodo Set 
        public async void SetUsers(string operacion, Usuario user)
        {
            try
            {

                if (user == null)
                {
                    throw new ArgumentNullException(nameof(user));
                }

                string procedureName = "dbo.dbSpUsuariosSet";
                SqlParameter[] parameters =
                {
                    new SqlParameter("@Id", user.Id),
                    new SqlParameter("@Nombre", user.Nombre),
                    new SqlParameter("@Apellido", user.Apellido),
                    new SqlParameter("@Correo", user.Correo),
                    new SqlParameter("@IdCompania", user.IdCompania),
                    new SqlParameter("@Cargo", user.Cargo),
                    new SqlParameter("@Rol", user.Rol),
                    new SqlParameter("@Estado", ""),
                    new SqlParameter("@Operacion", operacion),
               };
                await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
                // _sqlClient.
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al crear/modificar un usuario: {ex.Message}");
                throw;
            }
        }

        // Metodo Delete
        public async Task<DataTable> DeleteUser(string userId)
        {
            try
            {


                string procedureName = "dbo.dbSpUsuariosDel";
                SqlParameter[] parameters =
                {
                    new SqlParameter("@Id", userId)
                };
                return await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al eliminar un usuario: {ex.Message}");
                throw;
            }

        }

        // Metodo Active        
        public async Task<DataTable> ActiveUser(string userId, int estado)
        {
            try
            {
                string procedureName = "dbo.dbSpUsuariosActive";
                SqlParameter[] parameters =
                {
                    new SqlParameter("@Id", userId),
                    new SqlParameter("@Estado", estado)
                };
                return await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
            }
            catch (Exception ex)
            {
                // Manejar errores aquí
                Console.WriteLine($"Error al carbiar el estado del usuario: {ex.Message}");
                throw;
            }
        }
        #endregion
    }
}
