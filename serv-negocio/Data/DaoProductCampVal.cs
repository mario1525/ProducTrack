using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoProductCampVal : BaseDao<ProductCampVal>
    {
        public DaoProductCampVal(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<ProductCampVal>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpProductCampValGet";
            var parameters = new[]
            {
                new SqlParameter("@IdProductCampVal", Id),
                new SqlParameter("@Valor", ""),
                new SqlParameter("@IdProductCamp", ""),
                new SqlParameter("@IdRegisProduct", ""),
                new SqlParameter("@Estado", 1),                
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<ProductCampVal>> Gets(string IdProduct)
        {
            const string procedureName = "dbo.dbSpProductCampValGet";
            var parameters = new[]
            {
                new SqlParameter("@IdProductCampVal", ""),
                new SqlParameter("@Valor", ""),
                new SqlParameter("@IdProductCamp", ""),
                new SqlParameter("@IdRegisProduct", IdProduct),
                new SqlParameter("@Estado", 1),                
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, ProductCampVal productCampVal)
        {
            if (productCampVal == null)
            {
                throw new ArgumentNullException(nameof(productCampVal));
            }

            string procedureName = "dbo.dbSpProductCampValSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", productCampVal.Id),
                new SqlParameter("@Valor", productCampVal.Valor),
                new SqlParameter("@IdProductCamp", productCampVal.IdProductCamp),
                new SqlParameter("@IdRegisProduct", productCampVal.IdRegisProduct),
                new SqlParameter("@Estado", productCampVal.Estado),                
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpProductCampValDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpProductCampValActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de ProductCampVal
        protected override List<ProductCampVal> MapDataTableToList(DataTable dataTable)
        {
            List<ProductCampVal> productCampValList = new List<ProductCampVal>();
            foreach (DataRow row in dataTable.Rows)
            {
                ProductCampVal productCampVal = new ProductCampVal
                {
                    Id = row["Id"].ToString(),
                    Valor = row["Valor"].ToString(),
                    IdProductCamp = row["IdProductCamp"].ToString(),
                    IdRegisProduct = row["IdRegisProduct"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = row["Fecha_log"].ToString()
                };
                productCampValList.Add(productCampVal);
            }
            return productCampValList;
        }
    }
}
