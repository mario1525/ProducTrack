using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Producto/Campo")]
    [ApiController]
    public class ProductCampController : ControllerBase
    {
        private readonly ProductCampLogical _Logical;
        public ProductCampController(ProductCampLogical camp)
        {
            _Logical = camp;
        }

        // GET api/Producto/Campo/Producto/5
        [HttpGet("Producto/{idProduct}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<ProductCamp>> Gets(string idProduct)
        {
            return await _Logical.Gets(idProduct);
        }

        // GET api/Producto/Campo/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<ProductCamp>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Producto/Campo
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] ProductCamp value)
        {
            return _Logical.Create(value);
        }


        // PUT api/Producto/Campo/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] ProductCamp value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Producto/Campo/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
