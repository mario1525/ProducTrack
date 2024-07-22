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
    const Id = tokenDecoded['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'] || '';
    const IdCompania = tokenDecoded.IdCompania ? tokenDecoded.IdCompania : '';
    const Rol = tokenDecoded['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] || '';
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
  async setTokenInCookie(tokenObj: { token: string }): Promise<void> {
    const token = tokenObj.token; // Extraer la cadena del token del objeto
   // console.log("Token being set:", token);
    this.cookieService.set('token', token, {
      expires: 0.5, // 0.5 días (12 horas)
      path: '/',
      sameSite: 'Strict',
      secure: true,
    });
    return;
}


  // Método para obtener el token desde las cookies
  getTokenFromCookie(): string | '' {
    const tokenString = this.cookieService.get('token');
    //console.log("Token from Cookie:", tokenString);
    return tokenString;
}

  // Método para eliminar el token de las cookies
  async removeTokenFromCookie(): Promise<boolean> {
    this.cookieService.delete('token', '/', '', true, 'Strict');
    return true;
  }
}
