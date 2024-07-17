import { Injectable } from '@angular/core';
import { jwtDecode as jwt } from 'jwt-decode';
import { CookieService } from 'ngx-cookie-service';
import { Usuario, UsuarioJwtPayload } from 'src/types/usuarios';

@Injectable({
  providedIn: 'root'
})
export class TokenserviceService {

  constructor(private cookieService: CookieService) { }

  verifyToken(token: string): boolean {
    if (!token) return false;
    try {
      const verify = jwt(token);
      return true;
    } catch (error) {
      console.error('Error al decodificar el token:', error);
      return false;
    }
  }

  decodetoken(token: string): Usuario {
    const tokenDecoded: UsuarioJwtPayload = jwt(token);
    const Id = tokenDecoded.Id ? tokenDecoded.Id : '';
    const IdCompania = tokenDecoded.IdCompania ? tokenDecoded.IdCompania : '';
    const Rol = tokenDecoded?.Rol ? tokenDecoded?.Rol : '';
    return {
      sub: tokenDecoded.sub ? tokenDecoded.sub : '',
      Rol: Rol,
      IdCompania:IdCompania,
      Id: Id,
    };
  }

  istokenexpired(token: string): boolean {
    const tokenDecoded = jwt(token);
    const exp = tokenDecoded.exp ? tokenDecoded.exp : 0;
    const now = Date.now();
    if (exp < now) {
      return true;
    }
    return false;
  }

  // Método para establecer el token en las cookies
  async setTokenInCookie(token: string): Promise<void> {
    this.cookieService.set('token', token, {
      expires: 0.5,
      path: '/',
      sameSite: 'Strict',
      secure: true,
    });    
    return;
  }

  // Método para obtener el token desde las cookies
  getTokenFromCookie(): string  {
    const token = { token: this.cookieService.get('token') };
    console.log(token.token)
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJtYXJpbyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwiSWRDb21wYW5pYSI6ImQ3ZjllZmI5LTU3Y2QtNDk3ZS1iYTMwLWMxOTRhMzIxZWZpcyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiNmQ0YWJlNDMtZWU3OS00OTg5LTkzYWQtNDRhNzQ5MGY4NzFkIiwianRpIjoiMWZjMTczM2QtOWMxMi00NmRkLWE2OTctOTBkMGY3OTg3MjU3IiwiZXhwIjoxNzE5NjU1NTE5NjA2LCJpc3MiOiJtYXJpaWpkYWgiLCJhdWQiOiJhc2RmaWlpZWxzZGoifQ.RAp3Yuh0-P3jzEOFaIzdZVmYN800wPsbBl55xsqeuaY";
  }

  // Método para eliminar el token de las cookies
  async removeTokenFromCookie(): Promise<boolean> {
    this.cookieService.delete('token', '/', '', true, 'Strict');
    return true;
  }
}
