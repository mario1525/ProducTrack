using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
//using Microsoft.Data;
using System.Data;


namespace Data
{
    public class DaoUsuario
    {
        #region declaracion de variables         
        SqlClient ob_SQLClient = null;
        #endregion

        #region Metodos 

        private readonly SqlClient _sqlClient;

        public DaoUsuario(SqlClient dbContext)
        {
            _sqlClient = dbContext;
        }
        Guid uid = Guid.NewGuid();

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

        // Metodo Delete
        public async Task<DataTable> DeleteUser(string userId)
        {
            string procedureName = "dbo.dbSpUsuariosDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", userId)
            };
            return await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async Task<DataTable> ActiveUser(string userId)
        {
            string procedureName = "dbo.dbSpUsuariosActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", userId)
            };
            return await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
        }



        #endregion
    }
}
