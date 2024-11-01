﻿using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;


namespace Data
{
    public class DaoOrden : BaseDao<Orden>
    {
        public DaoOrden(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<Orden>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@IdOrden", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<Orden>> Gets(string IdCompania)
        {
            const string procedureName = "dbo.dbSpOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@IdOrden", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", IdCompania),
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, CreateOrden orden)
        {
            if (orden == null)
            {
                throw new ArgumentNullException(nameof(orden));
            }

            DataTable camposTable = new DataTable();
            camposTable.Columns.Add("id", typeof(string));
            camposTable.Columns.Add("nombre", typeof(string));
            camposTable.Columns.Add("tipodato", typeof(string));
            camposTable.Columns.Add("obligatorio", typeof(bool));

            // Recorrer el array de campos y agregar cada campo como una fila al DataTable
            if(operacion == "I")
            {
                foreach (var campo in orden.Campos)
                {
                    camposTable.Rows.Add(campo.Id, campo.Nombre, campo.TipoDato, campo.Obligatorio);
                }

            }
            

            string procedureName = "dbo.dbSpOrdenSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", orden.Orden.Id),
                new SqlParameter("@Nombre", orden.Orden.Nombre),
                new SqlParameter("@IdCompania", orden.Orden.IdCompania),
                new SqlParameter("@IdProceso", orden.Orden.IdProceso),
                new SqlParameter("@Estado", orden.Orden.Estado),
                new SqlParameter
                    {
                        ParameterName = "@campos",
                        SqlDbType = SqlDbType.Structured,
                        Value = camposTable // Pasar el DataTable como parámetro
                    },
                new SqlParameter("@Operacion", operacion),               
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpOrdenDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpOrdenActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de Orden
        protected override List<Orden> MapDataTableToList(DataTable dataTable)
        {
            List<Orden> ordenList = new List<Orden>();
            foreach (DataRow row in dataTable.Rows)
            {
                Orden orden = new Orden
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    IdCompania = row["Compania"].ToString(),
                    IdProceso = row["IdProceso"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    //Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = row["Fecha_log"].ToString(),
                };
                ordenList.Add(orden);
            }
            return ordenList;
        }
    }
}