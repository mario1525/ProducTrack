﻿using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoRegisOrden : BaseDao<RegisOrden>
    {
        public DaoRegisOrden(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<RegisOrden>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpRegisOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@IdOrden", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<RegisOrden>> Gets()
        {
            const string procedureName = "dbo.dbSpRegisOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdOrden", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, RegisOrden regisOrden)
        {
            if (regisOrden == null)
            {
                throw new ArgumentNullException(nameof(regisOrden));
            }

            string procedureName = "dbo.dbSpRegisOrdenSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", regisOrden.Id),
                new SqlParameter("@IdOrden", regisOrden.IdOrden),
                new SqlParameter("@IdUsuario", regisOrden.IdUsuario),
                new SqlParameter("@Estado", regisOrden.Estado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpRegisOrdenDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpRegisOrdenActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de RegisOrden
        protected override List<RegisOrden> MapDataTableToList(DataTable dataTable)
        {
            List<RegisOrden> regisOrdenList = new List<RegisOrden>();
            foreach (DataRow row in dataTable.Rows)
            {
                RegisOrden regisOrden = new RegisOrden
                {
                    Id = row["Id"].ToString(),
                    IdOrden = row["IdOrden"].ToString(),
                    IdUsuario = row["IdUsuario"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = row["Fecha_log"].ToString()
                };
                regisOrdenList.Add(regisOrden);
            }
            return regisOrdenList;
        }
    }
}
