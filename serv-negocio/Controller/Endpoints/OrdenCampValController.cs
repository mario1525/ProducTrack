﻿using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/RegisOrden/Val")]
    [ApiController]
    public class OrdenCampValController : ControllerBase
    {
        private readonly OrdenCampVaLogical _Logical;

        public OrdenCampValController(OrdenCampVaLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/<Orden>/5
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<OrdenCampVal>> Gets(string idCompania)
        {
            return await _Logical.Gets(idCompania);
        }
        

        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public async Task<List<OrdenCampVal>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/<Orden>
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Post([FromBody] OrdenCampVal value)
        {
            return _Logical.Create(value);
        }

        // PUT api/<Orden>/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Put(string id, [FromBody] OrdenCampVal value)
        {
            value.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/<Orden>/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Usuario")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
