export type lab = {
    id: string;
    nombre: string;
    idCompania: string;
    estado: boolean;    
    fecha_log: string;
  }

  export type Camp = {
    id: string;
    nombre: string;
    tipoDato: string;
    unidadMedida: string;    
    idLab: string;
    estado: boolean;
    fecha_log: string; // Usar string si la fecha se maneja como cadena de texto
  }

  export type create_Lab = {
    lab: lab;
    campos: Camp[];
  } 