import { JwtPayload } from "jwt-decode";

export interface UsuarioJwtPayload extends JwtPayload {
  sub: string;
  Rol: string;
  IdCompania: string;
  Id: string;
}

export interface Usuario {
  sub: string;
  Rol: string;
  IdCompania: string;
  Id: string;
}
