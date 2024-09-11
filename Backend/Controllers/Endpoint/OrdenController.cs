using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Orden")]
    [ApiController]
    public class OrdenController : ControllerBase
    {
        private readonly OrdenLogical _Logical;

        public OrdenController(OrdenLogical logical)
        {
            _Logical = logical;
        }


        // GET: api/<OrdenController>/5
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<Orden>> Gets(string idCompania)
        {
            return await _Logical.Gets(idCompania);
        }

        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Orden>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/<OrdenController>
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] CreateOrden value)
        {
            return _Logical.Create(value);
        }

        // PUT api/<OrdenController>/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] Orden value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<OrdenController>/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
