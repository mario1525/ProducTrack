using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Orden/Tipo")]
    [ApiController]
    public class OrdenTipoController : ControllerBase
    {
        private readonly TipoOrdenLogical _Logical;

        public OrdenTipoController(TipoOrdenLogical logical)
        {
            _Logical = logical;
        }
        // GET api/Orden/Tipo/Proyecto/5
        [HttpGet("Proyecto/{idProyecto}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<TipoOrden>> Gets(string idProyecto)
        {
            return await _Logical.Gets(idProyecto);
        }

        // GET api/Orden/Tipo/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<TipoOrden>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Orden/Tipo
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] TipoOrden value)
        {
            return _Logical.Create(value);
        }


        // PUT api/Orden/Tipo/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] TipoOrden value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Orden/Tipo/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}

