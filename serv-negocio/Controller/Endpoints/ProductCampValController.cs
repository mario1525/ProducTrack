using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/Producto/Val")]
    [ApiController]
    public class ProductCampValController : ControllerBase
    {
        private readonly RegisProductCampValLogical _Logical;

        public ProductCampValController(RegisProductCampValLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/Producto/Val/Producto/5
        [HttpGet("Producto/{idRegisProduct}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<ProductCampVal>> Gets(string idRegisProduct)
        {
            return await _Logical.Gets(idRegisProduct);
        }

        // GET: api/Producto/Val/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<ProductCampVal>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST: api/Producto/Val
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Post([FromBody] ProductCampVal value)
        {
            return _Logical.Create(value);
        }

        // PUT: api/Producto/Val/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Put(string id, [FromBody] ProductCampVal value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Producto/Val/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
