using Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Controllers.Endpoint
{
    [Route("api/Credential")]
    [ApiController]
    public class CredentialController : ControllerBase
    {
        private readonly UsuarioCredentialLogical _UserLogical;

        public CredentialController(UsuarioCredentialLogical userLogical)
        {
            _UserLogical = userLogical;
        }


        // POST api/<CredentialController>
        [HttpPost]
        [Authorize]
        public Mensaje Post([FromBody] UsuarioCredential value)
        {
           return _UserLogical.CreateUsuario(value);
        }

        // PUT api/<CredentialController>/5
        [HttpPut("{id}")]
        [Authorize]
        public Mensaje Put(string id, [FromBody] UsuarioCredential value)
        {
            value.Id = id;
            return _UserLogical.UpdateUsuario(value);
        }

        // DELETE api/<CredentialController>/5
        [HttpDelete("{id}")]
        [Authorize]
        public Mensaje Delete(string id)
        {
            return _UserLogical.DeleteUsuario(id);
        }
    }
}
