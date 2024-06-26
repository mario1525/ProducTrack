using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Product/Campo")]
    [ApiController]
    public class ProductCampController : ControllerBase
    {
        private readonly ProductCampLogical _Logical;
        public ProductCampController(ProductCampLogical camp)
        {
            _Logical = camp;
        }

        // GET api/<ProductCampController>/5
        [HttpGet("{idOrden}")]
        [Authorize]
        public async Task<List<ProductCamp>> Get(string idProduct)
        {
            return await _Logical.Gets(idProduct);
        }

        // POST api/<ProductCampController>
        [HttpPost]
        [Authorize]
        public Mensaje Post([FromBody] ProductCamp value)
        {
            return _Logical.Create(value);
        }


        // PUT api/<ProductCampController>/5
        [HttpPut("{id}")]
        [Authorize]
        public Mensaje Put(string id, [FromBody] ProductCamp value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<productCampController>/5
        [HttpDelete("{id}")]
        [Authorize]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
