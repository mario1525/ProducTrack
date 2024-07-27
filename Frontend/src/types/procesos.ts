export type Proceso = {
    id: string;
    nombre: string;
    idCompania: string;
    estado: boolean; 
    fecha_log: string;
  }



export type Etapa = {
  id: string;
  nombre: string;
  idProceso: string;
  nEtapa: number;
  estado: boolean;   
  fecha_log: string;
}

export type create_Proces = {
  process: Proceso;
  procesEtaps: Etapa[];
}