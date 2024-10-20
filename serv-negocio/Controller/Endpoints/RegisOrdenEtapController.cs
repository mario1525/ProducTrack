using Microsoft.AspNetCore.Mvc;
using Entity;
using Services;
using Microsoft.AspNetCore.Authorization;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/Orden/Etapa")]
    [ApiController]
    public class RegisOrdenEtapController : ControllerBase
    {
        private readonly RegisOrdenEtapLogical _Logical;

        public RegisOrdenEtapController(RegisOrdenEtapLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/Orden/Etapa/5
        [HttpGet("{idOrden}/{idProEtap}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisOrdenProcesEtap>> Get(string idOrden, string idProEtap)
        {
            return await _Logical.Get(idOrden, idProEtap);
        }       

        // POST api/<RegisOrdenEtapController>
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Post([FromBody] RegisOrdenProcesEtap value)
        {
            return _Logical.create(value);
        }

        // PUT api/Orden/Etapa/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/Orden/Etapa/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public void Delete(int id)
        {
        }
    }
}
