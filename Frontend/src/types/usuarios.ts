import { JwtPayload } from "jwt-decode";

export interface UsuarioJwtPayload extends JwtPayload {
  sub: string;
  'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'?: string;
  IdCompania: string;
  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'?: string;
  Id: string;
}

export type UsuarioToken =  {
  sub: string;
  Rol: string;
  IdCompania: string;
  Id: string;
}

export type Usuario =  {
  id: string;
  identificacion: string;
  nombre: string;
  apellido: string;
  correo: string;
  idCompania: string;
  cargo: string;
  rol: string;
  estado: boolean;
  fecha_log: string;
}

export type Credential =  {
  id: string;  
  usuario: string;
  contrasenia: string;
  correo: string;
  idUsuario: string; 
  estado: boolean;
  fecha_log: string;
}
