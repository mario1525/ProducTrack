using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/Orden/Val")]
    [ApiController]
    public class OrdenCampValController : ControllerBase
    {
        private readonly OrdenCampVaLogical _Logical;

        public OrdenCampValController(OrdenCampVaLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/Orden/Orden/Val/5
        [HttpGet("Orden/{idRegisOrden}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<OrdenCampVal>> Gets(string idRegisOrden)
        {
            return await _Logical.Gets(idRegisOrden);
        }

        // GET: api/Orden/Val/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<OrdenCampVal>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Orden/Val
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Post([FromBody] OrdenCampVal value)
        {
            return _Logical.Create(value);
        }

        // PUT api/Orden/Val/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Put(string id, [FromBody] OrdenCampVal value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Orden/Val/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
