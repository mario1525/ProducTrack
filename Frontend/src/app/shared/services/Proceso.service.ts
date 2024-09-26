import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { Proceso, Etapa, create_Proces, Etapas } from 'src/types/procesos'


@Injectable({
    providedIn: 'root'
  })
  export class procesoService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Procesos(id: string): Observable<Proceso[] | []> {    
    const url = `${this.apiUrl}proceso/compania/${id}`;
    return this.http.get<Proceso[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener(id: string): Observable<Proceso[] | []> {    
    const url = `${this.apiUrl}proceso/${id}`;
    return this.http.get<Proceso[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create(Proceso: create_Proces): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}proceso`;
    return this.http.post<{mensaje: string}>(url, Proceso, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update(id: string, Proceso: Proceso): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}proceso/${id}`;
    return this.http.put<{mensaje: string}>(url, Proceso, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}proceso/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }


  // etapas

  obtener_etapas_Orden(id: string): Observable<Etapas> {    
    const url = `${this.apiUrl}etapa/orden/${id}`;
    return this.http.get<Etapas>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_etapas_Proceso(id: string): Observable<Etapa[] | []> {    
    const url = `${this.apiUrl}etapa/proceso/${id}`;
    return this.http.get<Etapa[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_etapa(id: string): Observable<Etapa[] | []> {    
    const url = `${this.apiUrl}Etapa/${id}`;
    return this.http.get<Etapa[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create_etapa(Value: Etapa): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}Etapa`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update_etapa(id: string, Value: Etapa): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}Etapa/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete_etapa(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}Etapa/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

}