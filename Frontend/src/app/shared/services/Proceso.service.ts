import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { Proceso, Etapa } from 'src/types/procesos'


@Injectable({
    providedIn: 'root'
  })
  export class procesoService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Procesos(id: string): Observable<Proceso[] | []> {    
    const url = `${this.apiUrl}api/Proceso/Compania/${id}`;
    return this.http.get<Proceso[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_etapas_Procesos(id: string): Observable<Etapa[] | []> {    
    const url = `${this.apiUrl}api/Etapa/${id}`;
    return this.http.get<Etapa[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener(id: string): Observable<Proceso[] | []> {    
    const url = `${this.apiUrl}api/Proceso/${id}`;
    return this.http.get<Proceso[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create(Proceso: Proceso): Observable<any> {
    const url = `${this.apiUrl}api/Proceso`;
    return this.http.post<{mensaje: string}>(url, Proceso, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update(id: string, Proceso: Proceso): Observable<any> {
    const url = `${this.apiUrl}api/Proceso/${id}`;
    return this.http.put<{mensaje: string}>(url, Proceso, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete(id: string): Observable<any> {
    const url = `${this.apiUrl}api/Proceso/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }
}