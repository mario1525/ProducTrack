﻿using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Lab/Campo")]
    [ApiController]
    public class LabCampController : ControllerBase
    {
        private readonly LabCampLogical _Logical;
        public LabCampController(LabCampLogical camp)
        {
            _Logical = camp;
        }

        // GET api/<labCampController>/5
        [HttpGet("{idOrden}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public async Task<List<LabCamp>> Get(string idOrden)
        {
            return await _Logical.Gets(idOrden);
        }

        // POST api/<labCampController>
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Post([FromBody] LabCamp value)
        {
            return _Logical.Create(value);
        }


        // PUT api/<labCampController>/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Put(string id, [FromBody] LabCamp value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<labCampController>/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
