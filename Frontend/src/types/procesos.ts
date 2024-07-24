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
  estado: boolean;
  eliminado: boolean; 
  fecha_log: string;
}
