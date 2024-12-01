import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { Proyecto } from 'src/types/proyecto';


@Injectable({
    providedIn: 'root'
  })
  export class ProyectoService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_proyectos(id: string): Observable<Proyecto[] | []> {    
    const url = `${this.apiUrl}proyecto/compania/${id}`;
    return this.http.get<Proyecto[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_proyecto(id: string ): Observable<Proyecto[] | []> {    
    const url = `${this.apiUrl}proyecto/${id}`;
    return this.http.get<Proyecto[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create_proyecto(proyecto: Proyecto): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}proyecto`;
    return this.http.post<{mensaje: string}>(url, proyecto, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update_proyecto(id: string, proyecto : Proyecto): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}proyecto/${id}`;
    return this.http.put<{mensaje: string}>(url, proyecto, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete_proyecto(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}proyecto/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }
}


