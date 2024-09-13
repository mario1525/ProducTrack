using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Etapa")]
    [ApiController]
    public class EtapaController : ControllerBase
    {
        private readonly EtapaProcesoLogical _Logical;

        public EtapaController(EtapaProcesoLogical logical)
        {
            _Logical = logical;
        }

        // GET api/Etapa/Proceso/5
        [HttpGet("Proceso/{idProceso}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<ProcesEtap>> Gets(string idProceso)
        {
            return await _Logical.Gets(idProceso);
        }

        // GET api/Etapa/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<ProcesEtap>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Etapa
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] ProcesEtap value)
        {
            return _Logical.Create(value);
        }


        // PUT api/Etapa/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] ProcesEtap value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Etapa/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
