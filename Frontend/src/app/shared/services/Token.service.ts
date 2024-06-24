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
  getTokenFromCookie(): { token: string } {
    const token = { token: this.cookieService.get('token') };
    return token;
  }

  // Método para eliminar el token de las cookies
  async removeTokenFromCookie(): Promise<boolean> {
    this.cookieService.delete('token', '/', '', true, 'Strict');
    return true;
  }
}
