using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Orden/Campo")]
    [ApiController]
    public class OrdenCampController : ControllerBase
    {
        private readonly OrdenCampLogical _Logical;

        public OrdenCampController(OrdenCampLogical logical)
        {
            _Logical = logical;
        }
        // GET api/Orden/Campo/Orden/5
        [HttpGet("Orden/{idOrden}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<OrdenCamp>> Gets(string idOrden)
        {
            return await _Logical.Gets(idOrden);
        }

        // GET api/Orden/Campo/5
        [HttpGet("/{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<OrdenCamp>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Orden/Campo
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] OrdenCamp value)
        {
            return _Logical.Create(value);
        }


        // PUT api/Orden/Campo/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] OrdenCamp value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Orden/Campo/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
