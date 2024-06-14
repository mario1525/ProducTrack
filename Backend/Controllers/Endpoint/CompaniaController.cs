using Microsoft.AspNetCore.Mvc;
using Entity;
using Services;
using Microsoft.AspNetCore.Authorization;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Compania")]
    [ApiController]
    public class CompaniaController : ControllerBase
    {
        private readonly CompaniaLogical _CompaniaLogical;

        public CompaniaController (CompaniaLogical CompaniaLogical)
        {
            _CompaniaLogical = CompaniaLogical;
        }
        // GET: api/<CompaniaController>
        [HttpGet]
        [Authorize]
        public async  Task<List<Compania>> Get()
        {
            return await _CompaniaLogical.GetCompanias();
        }

        // GET api/<CompaniaController>/5
        [HttpGet("{id}")]
        [Authorize]
        public async Task<List<Compania>> Get(string id)
        {
            

            return await _CompaniaLogical.GetCompania(id);
        }

        // POST api/<CompaniaController>
        [HttpPost]
        [Authorize]
        public Mensaje Post([FromBody] Compania compania)
        {
            return _CompaniaLogical.CreateCompania(compania);
        }

        // PUT api/<CompaniaController>/5
        [HttpPut("{id}")]
        [Authorize]
        public Mensaje Put(string id, [FromBody] Compania compania)
        {
            compania.Id = id;
            return _CompaniaLogical.UpdateCompania(compania);
        }

        // DELETE api/<CompaniaController>/5
        [HttpDelete("{id}")]
        [Authorize]
        public Mensaje Delete(string id)
        {
            return _CompaniaLogical.DeleteCompania(id);
        }
    }
}
