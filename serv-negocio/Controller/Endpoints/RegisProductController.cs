using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/Registro/Producto")]
    [ApiController]
    public class RegisProductController : ControllerBase
    {
        private readonly RegisProductLogical _Logical;

        public RegisProductController(RegisProductLogical logical)
        {
            _Logical = logical;
        }
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<RegisProduct>> Gets(string idCompania)
        {

            return await _Logical.Gets(idCompania);
        }

        [HttpGet("Usuario/{idUsuario}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<RegisProduct>> GetUsuario(string idUsuario)
        {
            return await _Logical.GetsUser(idUsuario);
        }

        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<RegisProduct>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/<OrdenController>
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Post([FromBody] CreateRegisProduct value)
        {
            return _Logical.Create(value);
        }

        // PUT api/<OrdenController>/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Put(string id, [FromBody] RegisProduct value)
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
