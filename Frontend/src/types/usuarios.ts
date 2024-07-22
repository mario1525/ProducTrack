import { JwtPayload } from "jwt-decode";

export interface UsuarioJwtPayload extends JwtPayload {
  sub: string;
  'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'?: string;
  IdCompania: string;
  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'?: string;
  Id: string;
}

export type Usuario =  {
  sub: string;
  Rol: string;
  IdCompania: string;
  Id: string;
}
