using Entity;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Usuario")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly UsuarioLogical _UserLogical;

        public UsuarioController(UsuarioLogical usuariological)
        {
            _UserLogical = usuariological;
        }
        // GET: api/<UsuarioController>
        [HttpGet]
        public async Task<List<Usuario>> Get()
        {
            return await _UserLogical.GetUsuarios();
        }

        // GET api/<UsuarioController>/5
        [HttpGet("{id}")]
        public async Task<List<Usuario>> Get(string id)
        {
            return await _UserLogical.GetUsuario(id) ;
        }

        // POST api/<UsuarioController>
        [HttpPost]
        public Mensaje Post([FromBody] Usuario value)
        {
            return _UserLogical.CreateUsuario(value);
        }

        // PUT api/<UsuarioController>/5
        [HttpPut("{id}")]
        public  Mensaje Put(string id, [FromBody] Usuario value)
        {
            value.Id = id;
            return  _UserLogical.UpdateUsuario(value);
        }

        // DELETE api/<UsuarioController>/5
        [HttpDelete("{id}")]
        public Mensaje Delete(string id)
        {
            return _UserLogical.DeleteUsuario(id);
        }
    }
}
