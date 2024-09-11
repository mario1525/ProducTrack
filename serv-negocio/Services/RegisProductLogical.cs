using Data;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class RegisProductLogical
    {
        private readonly DaoRegisProduct _orden;
        private readonly DaoProductCampVal _camp;


        public RegisProductLogical(DaoRegisProduct value, DaoProductCampVal camp)
        {
            _orden = value;
            _camp = camp;
        }

        public async Task<List<RegisProduct>> Gets(string IdCompania)
        {
            
            return await _orden.Gets(IdCompania);
        }

        public async Task<List<RegisProduct>> GetsUser(string IdUsuario)
        {
            return await _orden.GetsUser(IdUsuario);
        }        

        public async Task<List<RegisProduct>> Get(string Id)
        {
            return await _orden.Get(Id);
        }

        public Mensaje Create(CreateRegisProduct value)
        {
            Guid uid = Guid.NewGuid();
            value.Producto.Id = uid.ToString();
            _orden.Set("I", value.Producto);
            foreach (ProductCampVal campo in value.Campos)
            {
                Guid uidCamp = Guid.NewGuid();
                campo.Id = uidCamp.ToString();
                campo.IdRegisProduct = uid.ToString();
                _camp.Set("I", campo);
            }

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(RegisProduct value)
        {
            _orden.Set("A", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _orden.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;
        }

        public Mensaje Active(string Id, int estado)
        {
            _orden.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "estado actualizado";
            return mensaje;
        }
    }
}
