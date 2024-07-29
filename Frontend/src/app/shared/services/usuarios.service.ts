import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { Usuario, Credential } from 'src/types/usuarios'

@Injectable({
    providedIn: 'root'
})
export class UsuarioService {
    private apiUrl = url;
    constructor(private http: HttpClient, private auth:TokenserviceService ) { }

    obtener_usuarios(): Observable<Usuario[] | []> {    
        const url = `${this.apiUrl}api/Usuario`;
        return this.http.get<Usuario[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
      }
    
      obtener_usuariosCompania(idCompania: string ): Observable<Usuario[] | []> {    
        const url = `${this.apiUrl}api/Usuario/Compania/${idCompania}`;
        return this.http.get<Usuario[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
      }

      obtener_usuario(idUsuario: string ): Observable<Usuario[] | []> {    
        const url = `${this.apiUrl}api/Usuario/${idUsuario}`;
        return this.http.get<Usuario[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
      }
    
      create_usuario(usuario: Usuario): Observable<any> {
        const url = `${this.apiUrl}api/Usuario`;
        return this.http.post<{mensaje: string}>(url, usuario, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }

      create_Credential(usuario: Credential): Observable<any> {
        const url = `${this.apiUrl}api/Credential`;
        return this.http.post<{mensaje: string}>(url, usuario, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }
    
      update_usuario(id: string, usuario: Usuario): Observable<any> {
        const url = `${this.apiUrl}api/Usuario/${id}`;
        return this.http.put<{mensaje: string}>(url, usuario, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }
    
      delete_usuario(id: string): Observable<any> {
        const url = `${this.apiUrl}api/Usuario/${id}`;
        return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }
}