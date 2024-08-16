import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import url from './../../../helpers/indexurl';

@Injectable({
  providedIn: 'root'
})
export class AuthtenticationService {
  private apiUrl = url ; // Reemplaza con la URL real de tu backend

  constructor(private http: HttpClient) { }

  autenticar(data: object): Observable<any> {
    const url = `${this.apiUrl}auth/login`;
    // Define el objeto con usuario y contraseña
    const datosAutenticacion = data;
    const respuesta = this.http.post(url, datosAutenticacion);
    // Realiza la solicitud POST
    return respuesta;
  }  
}
