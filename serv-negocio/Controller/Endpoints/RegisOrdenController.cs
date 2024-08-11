using Entity;
using Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/Registro/Orden")]
    [ApiController]
    public class RegisOrdenController : ControllerBase
    {
        private readonly RegisOrdenLogical _Logical;

        public RegisOrdenController(RegisOrdenLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/<OrdenController>/5
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<RegisOrden>> Gets(string idCompania)
        {
            
            return await _Logical.Gets(idCompania);
        }

        [HttpGet("Usuario/{idUsuario}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<RegisOrden>> GetUsuario(string idUsuario)
        {
            return await _Logical.GetsUser(idUsuario);
        }

        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<RegisOrden>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/<OrdenController>
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Post([FromBody] CreateRegisOrden value)
        {
            return _Logical.Create(value);
        }

        // PUT api/<OrdenController>/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Put(string id, [FromBody] RegisOrden value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<OrdenController>/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
