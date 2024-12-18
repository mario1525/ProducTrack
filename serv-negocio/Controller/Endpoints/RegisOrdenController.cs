﻿using Entity;
using Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/Orden")]
    [ApiController]
    public class RegisOrdenController : ControllerBase
    {
        private readonly RegisOrdenLogical _Logical;

        public RegisOrdenController(RegisOrdenLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/Orden/Compania/5
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisOrden>> Gets(string idCompania)
        {
            
            return await _Logical.Gets(idCompania);
        }

        // GET: api/Orden/Usuario/5
        [HttpGet("Usuario/{idUsuario}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisOrden>> GetUsuario(string idUsuario)
        {
            return await _Logical.GetsUser(idUsuario);
        }

        // GET: api/Orden/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisOrden>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Orden
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Post([FromBody] CreateRegisOrden value)
        {
            return _Logical.Create(value);
        }

        // PUT api/Orden/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Put(string id, [FromBody] CreateRegisOrden value)
        {
            value.Orden.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Orden/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
