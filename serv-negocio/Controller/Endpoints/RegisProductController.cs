﻿using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controller.Endpoints
{
    [Route("api/Producto")]
    [ApiController]
    public class RegisProductController : ControllerBase
    {
        private readonly RegisProductLogical _Logical;

        
        public RegisProductController(RegisProductLogical logical)
        {
            _Logical = logical;
        }

        // GET: api/Producto/Compania/5
        [HttpGet("Compania/{idCompania}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisProduct>> Gets(string idCompania)
        {

            return await _Logical.Gets(idCompania);
        }

        // GET: api/Producto/Orden/5
        [HttpGet("Orden/{idOrden}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisProduct>> GetsOrden(string idOrden)
        {

            return await _Logical.GetsOrden(idOrden);
        }

        // GET: api/Producto/Usuario/5
        [HttpGet("Usuario/{idUsuario}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisProduct>> GetUsuario(string idUsuario)
        {
            return await _Logical.GetsUser(idUsuario);
        }

        // GET: api/Producto/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public async Task<List<RegisProduct>> Get(string id)
        {
            return await _Logical.Get(id);
        }

        // POST api/Producto
        [HttpPost]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Post([FromBody] CreateRegisProduct value)
        {
           return _Logical.Create(value);
        }

        // PUT api/Producto/5
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Put(string id, [FromBody] CreateRegisProduct value)
        {
            value.Producto.Id = id;
            return _Logical.Update(value);
        }

        // DELETE api/Producto/5
        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Admin-Compania,Cordinador")]
        public Mensaje Delete(string id)
        {
            return _Logical.Delete(id);
        }
    }
}
