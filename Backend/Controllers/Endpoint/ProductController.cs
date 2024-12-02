using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Producto")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly ProductLogical _Logical;

        public ProductController(ProductLogical logical)
        {
            _Logical = logical;
        }


        // GET: api/Producto/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Producto>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // GET: api/Producto/Compania/5
        [HttpGet("Compania/{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<Producto>> Gets(string id)
        {
            return await _Logical.Gets(id);
        }

        // GET: api/Producto/Proyecto/5
        [HttpGet("Proyecto/{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<Producto>> GetsP(string id)
        {
            return await _Logical.GetsP(id);
        }

        // POST api/Producto
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] CreateProduct value)
        {
            return _Logical.Create(value);
        }

        // PUT api/Producto/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] Producto value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Producto/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
