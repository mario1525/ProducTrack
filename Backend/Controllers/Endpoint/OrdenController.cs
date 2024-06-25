using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Orden")]
    [ApiController]
    public class OrdenController : ControllerBase
    {
        private readonly OrdenLogical _Logical;

        public OrdenController(OrdenLogical logical)
        {
            _Logical = logical;
        }


        // GET: api/<OrdenController>/5
        [HttpGet("{id}")]
        [Authorize]
        public async Task<List<Orden>> Get(string id)
        {
            return await _Logical.Gets(id);
        }

        // GET api/<OrdenController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<OrdenController>
        [HttpPost]
        [Authorize]
        public Mensaje Post([FromBody] CreateOrden value)
        {
            return _Logical.Create(value);
        }

        // PUT api/<OrdenController>/5
        [HttpPut("{id}")]
        [Authorize]
        public Mensaje Put(string id, [FromBody] Orden value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<OrdenController>/5
        [HttpDelete("{id}")]
        [Authorize]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
