using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Lab")]
    [ApiController]
    public class labController : ControllerBase
    {
        private readonly LabLogical _Logical;

        public labController(LabLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/Lab/Compania/5
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Lab>> Gets(string idCompania)
        {
            return await _Logical.Gets(idCompania);
        }


        // GET: api/Lab/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<Lab>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Lab
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] CreateLab value)
        {
            return _Logical.Create(value);
        }

        // PUT api/Lab/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] Lab value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Lab/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
