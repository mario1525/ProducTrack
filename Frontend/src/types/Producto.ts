export type producto = {
    id: string;
    nombre: string;
    idCompania: string;
    idProceso: string;
    estado: boolean;    
    fecha_log: string;
  }

  export type Regisproducto = {
    id: string;
    idProduct: string;
    IdRegisOrden: string;
    IdUsuario: string;
    estado: boolean;    
    fecha_log: string;
  }

  export type Camp = {
    id: string;
    nombre: string;
    tipoDato: string;
    obligatorio: boolean;    
    idProduct: string;
    estado: boolean;
    fecha_log: string; // Usar string si la fecha se maneja como cadena de texto
  }

  export type create_Product = {
    producto: producto;
    campos: Camp[];
  } 