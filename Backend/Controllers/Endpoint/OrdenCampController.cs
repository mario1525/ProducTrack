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
        // GET api/<OrdenCampController>/5
        [HttpGet("{idOrden}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<OrdenCamp>> Gets(string idOrden)
        {
            return await _Logical.Gets(idOrden);
        }

        [HttpGet("Campo/{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<OrdenCamp>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/<OrdenCampController>
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] OrdenCamp value)
        {
            return _Logical.Create(value);
        }


        // PUT api/<OrdenCampController>/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] OrdenCamp value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<OrdenCampController>/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
