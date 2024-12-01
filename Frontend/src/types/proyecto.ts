
export type Proyecto = {
    id: string;
    nombre: string;
    descripcion: string;
    idCompania: string;    
    estado: boolean;
    fecha_log: string; // Usar string si la fecha se maneja como cadena de texto
  }