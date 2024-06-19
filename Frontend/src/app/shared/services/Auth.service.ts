import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CookieService } from 'ngx-cookie-service';

@Injectable({
  providedIn: 'root'
})
export class AuthtenticationService {
  private apiUrl = 'https://localhost:7022'; // Reemplaza con la URL real de tu backend

  constructor(private http: HttpClient, private cookieService: CookieService) { }

  autenticar(data: object): Observable<any> {
    const url = `${this.apiUrl}/api/auth`;
    // Define el objeto con usuario y contraseña
    const datosAutenticacion = data;
    const respuesta = this.http.post(url, datosAutenticacion);
    // Realiza la solicitud POST
    return respuesta;
  }

  // Método para establecer el token en las cookies
  setTokenInCookie({ Id, Rol }: { Id: string, Rol: string }): void {
    // Aquí 'miToken' es el nombre de la cookie, ajusta según tus necesidades
    this.cookieService.set('Id', Id);
    this.cookieService.set('Rol', Rol);
    return;
  }

  // Método para obtener el token desde las cookies
  getTokenFromCookie(): {"usuario":string,"rol":string} {
    // Aquí 'miToken' es el nombre de la cookie, ajusta según tus necesidades
    const usuario = {"usuario":this.cookieService.get('Id'),"rol":this.cookieService.get('Rol')};
    return usuario
  }

  // Método para eliminar el token de las cookies
  removeTokenFromCookie(): boolean {
    // Aquí 'miToken' es el nombre de la cookie, ajusta según tus necesidades
    this.cookieService.delete('Id');
    this.cookieService.delete('Rol');
    return true;
  }
}
