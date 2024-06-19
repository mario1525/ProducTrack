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

        // GET api/<ProcesoController>/5
        [HttpGet("{idCompania}")]
        [Authorize]
        public async Task<List<Proceso>> Get(string idCompania)
        {
            return await _Logical.Gets(idCompania);
        }        

        // POST api/<ProcesoController>
        [HttpPost]
        [Authorize]
        public Mensaje Post([FromBody] CreateProces value)
        {
            return _Logical.Create(value);
        }

        // PUT api/<ProcesoController>/5
        [HttpPut("{id}")]
        [Authorize]
        public Mensaje Put(string id, [FromBody] Proceso value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<ProcesoController>/5
        [HttpDelete("{id}")]
        [Authorize]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
