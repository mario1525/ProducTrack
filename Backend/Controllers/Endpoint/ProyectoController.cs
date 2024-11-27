using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Proyecto")]
    [ApiController]
    public class ProyectoController : ControllerBase
    {
        private readonly ProyectoLogical _ProyectoLogical;

        public ProyectoController(ProyectoLogical ProyectoLogical)
        {
            _ProyectoLogical = ProyectoLogical;
        }

        // GET: api/Proyecto/Compania/5
        [HttpGet("Compania/{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Proyecto>> Gets(string id)
        {
            return await _ProyectoLogical.Gets(id);
        }

        // GET: api/Proyecto/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Proyecto>> Get(string id)
        {
            return await _ProyectoLogical.Get(id);
        }

        // POST api/Proyecto
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] Proyecto Proyecto)
        {
            return _ProyectoLogical.Create(Proyecto);
        }

        // PUT api/Proyecto/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] Proyecto Proyecto)
        {
            Proyecto.Id = id;
            return _ProyectoLogical.Update(Proyecto);
        }

        // DELETE api/Proyecto/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _ProyectoLogical.Delete(id);
        }
    }
}
