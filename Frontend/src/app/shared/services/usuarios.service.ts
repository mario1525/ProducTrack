import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
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
        const url = `${this.apiUrl}usuario`;
        return this.http.get<Usuario[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
      }
    
      obtener_usuariosCompania(idCompania: string ): Observable<Usuario[] | []> {    
        const url = `${this.apiUrl}usuario/compania/${idCompania}`;
        return this.http.get<Usuario[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
      }

      obtener_usuario(idUsuario: string ): Observable<Usuario[] | []> {    
        const url = `${this.apiUrl}usuario/${idUsuario}`;
        return this.http.get<Usuario[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
      }

      obtener_Supervisores(idCompania: string ): Observable<Usuario[] | []> {    
        const url = `${this.apiUrl}usuario/supervisor/${idCompania}`;
        return this.http.get<Usuario[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
      }
    
      create_usuario(usuario: Usuario): Observable<{mensaje: string}> {
        const url = `${this.apiUrl}usuario`;
        return this.http.post<{mensaje: string}>(url, usuario, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }

      create_Credential(usuario: Credential): Observable<{mensaje: string}> {
        const url = `${this.apiUrl}usuario/credential`;
        return this.http.post<{mensaje: string}>(url, usuario, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }
    
      update_usuario(id: string, usuario: Usuario): Observable<{mensaje: string}> {
        const url = `${this.apiUrl}usuario/${id}`;
        return this.http.put<{mensaje: string}>(url, usuario, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }
    
      delete_usuario(id: string): Observable<{mensaje: string}> {
        const url = `${this.apiUrl}usuario/${id}`;
        return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
      }
}