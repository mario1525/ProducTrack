using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Proceso")]
    [ApiController]
    public class ProcesoController : ControllerBase
    {
        private readonly ProcesoLogical _Logical;

        public ProcesoController(ProcesoLogical procesoLogical)
        {
            _Logical = procesoLogical;
        }

        // GET: api/Proceso/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Proceso>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // GET: api/Proceso/Compania/5
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Proceso>> Gets(string idCompania)
        {
            return await _Logical.Gets(idCompania);
        }

        // POST api/Proceso
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] CreateProces value)
        {
            return _Logical.Create(value);
        }

        // PUT api/Proceso/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] Proceso value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Proceso/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
