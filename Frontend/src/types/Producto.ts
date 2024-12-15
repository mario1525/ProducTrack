export type producto = {
    id: string;
    nombre: string;
    idProyecto: string;
    idProceso: string;
    estado: boolean;    
    fecha_log: string;
  }

  export type Regisproducto = {
    id: string;
    idProduct: string;
    idRegisOrden: string;
    idProyecto: string;
    idUsuario: string;
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

  export type oCampV = {
    id: string;
    valor: string;
    idProductCamp: string;
    idRegisProduct: string;  
    estado: boolean;  
    fecha_log: string; // Usar string si la fecha se maneja como cadena de texto
  }

  export type create_Regis = {
    producto: Regisproducto;
    campos: oCampV[];
  }

  export type create_Product = {
    producto: producto;
    campos: Camp[];
  } 