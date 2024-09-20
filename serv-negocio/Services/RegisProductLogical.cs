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

        public async Task<List<RegisProduct>> GetsOrden(string IdOrden)
        {

            return await _orden.GetsOrden(IdOrden);
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
            string uid = DateTime.Now.ToString("yyyyMMddHHmmssffff"); ;
            value.Producto.Id = uid;
            _orden.Set("I", value.Producto);
            foreach (ProductCampVal campo in value.Campos)
            {
                string uidCamp = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                campo.Id = uidCamp;
                campo.IdRegisProduct = uid.ToString();
                _camp.Set("I", campo);
            }

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid;
            return mensaje;

        }

        public Mensaje Update(CreateRegisProduct value)
        {
            _orden.Set("A", value.Producto);
            foreach (ProductCampVal campo in value.Campos)
            {               
                _camp.Set("A", campo);
            }
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
