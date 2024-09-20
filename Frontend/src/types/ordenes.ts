export type orden = {
    id: string;
    nombre: string;
    idCompania: string;
    idProceso: string;
    estado: boolean;
    fecha_log: string; // Usar string si la fecha se maneja como cadena de texto
  }

  export type oCamp = {
    id: string;
    nombre: string;
    tipoDato: string;
    obligatorio: boolean;
    idOrden: string;
    estado: boolean;
    fecha_log: string; // Usar string si la fecha se maneja como cadena de texto
  }

  export type create_orden = {
    orden: orden;
    campos: oCamp[];
  }

  export type regisOrden = {
    id: string;
    idUsuario: string;
    idCompania: string;
    idOrden: string;
    estado: boolean;
    fecha_log: string;
  }

  export type oCampV = {
    id: string;
    valor: string;
    idOrdenCamp: string;
    idRegisOrden: string;    
    fecha_log: string; // Usar string si la fecha se maneja como cadena de texto
  }

  export type create_Regis = {
    orden: regisOrden;
    campos: oCampV[];
  }