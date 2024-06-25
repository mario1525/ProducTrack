using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/ORdenCamp")]
    [ApiController]
    public class OrdenCampController : ControllerBase
    {
        private readonly OrdenCampLogical _Logical;

        public OrdenCampController(OrdenCampLogical logical)
        {
            _Logical = logical;
        }
        // GET api/<OrdenCampController>/5
        [HttpGet("{idProceso}")]
        public async Task<List<OrdenCamp>> Get(string idOrden)
        {
            return await _Logical.Gets(idOrden);
        }

        // POST api/<OrdenCampController>
        [HttpPost]
        [Authorize]
        public Mensaje Post([FromBody] OrdenCamp value)
        {
            return _Logical.Create(value);
        }


        // PUT api/<OrdenCampController>/5
        [HttpPut("{id}")]
        [Authorize]
        public Mensaje Put(string id, [FromBody] OrdenCamp value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<OrdenCampController>/5
        [HttpDelete("{id}")]
        [Authorize]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
