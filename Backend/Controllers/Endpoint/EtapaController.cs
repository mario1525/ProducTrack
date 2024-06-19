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

        // GET api/<EtapaController>/5
        [HttpGet("{idProceso}")]
        public async Task<List<ProcesEtap>> Get(string idProceso)
        {
            return await _Logical.Gets(idProceso);
        }

        // POST api/<EtapaController>
        [HttpPost]
        [Authorize]
        public Mensaje Post([FromBody] ProcesEtap value)
        {
            return _Logical.Create(value);
        }


        // PUT api/<EtapaController>/5
        [HttpPut("{id}")]
        [Authorize]
        public Mensaje Put(string id, [FromBody] ProcesEtap value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<EtapaController>/5
        [HttpDelete("{id}")]
        [Authorize]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
