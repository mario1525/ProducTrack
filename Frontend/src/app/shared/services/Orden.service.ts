import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { orden, create_orden, create_Regis, oCamp, regisOrden, oCampV } from 'src/types/ordenes'


@Injectable({
    providedIn: 'root'
  })
  export class ordenService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Orden(id: string): Observable<orden[] | []> {    
    const url = `${this.apiUrl}orden/compania/${id}`;
    return this.http.get<orden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener(id: string): Observable<orden[] | []> {    
    const url = `${this.apiUrl}orden/${id}`;
    return this.http.get<orden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create(Value: create_orden): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update(id: string, Value: orden): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  // campo

  obtener_c_orden(id: string): Observable<oCamp[] | []> {    
    const url = `${this.apiUrl}orden/campos/${id}`;
    return this.http.get<oCamp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_c(id: string): Observable<oCamp[] | []> {    
    const url = `${this.apiUrl}orden/campo/${id}`;
    return this.http.get<oCamp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create_c(Value: oCamp): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/campo`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update_c(id: string, Value: oCamp): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/campo/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete_c(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/campo/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  // Refistro Orden 

  obtener_ROrdenC(id: string): Observable<regisOrden[] | []> {    
    const url = `${this.apiUrl}orden/registro/compania/${id}`;
    return this.http.get<regisOrden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtenerRU(id: string): Observable<regisOrden[] | []> {    
    const url = `${this.apiUrl}orden/registro/usuario/${id}`;
    return this.http.get<regisOrden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtenerR(id: string): Observable<regisOrden[] | []> {    
    const url = `${this.apiUrl}orden/registro/${id}`;
    return this.http.get<regisOrden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  createR(Value: create_Regis): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/registro`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  updateR(id: string, Value: create_Regis): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/registro/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  deleteR(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}orden/registro/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

    // Refistro Orden val

    obtener_ROrdenCV(id: string): Observable<oCampV[] | []> {    
      const url = `${this.apiUrl}orden/registro/values/${id}`;
      return this.http.get<oCampV[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
    }
  
    obtenerRV(id: string): Observable<oCampV[] | []> {    
      const url = `${this.apiUrl}orden/registro/val/${id}`;
      return this.http.get<oCampV[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
    }
  
    createRV(Value: oCampV): Observable<{mensaje: string}> {
      const url = `${this.apiUrl}orden/registro/val`;
      return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
    }
  
    updateRV(id: string, Value: orden): Observable<{mensaje: string}> {
      const url = `${this.apiUrl}orden/registro/val/${id}`;
      return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
    }
  
    deleteRV(id: string): Observable<{mensaje: string}> {
      const url = `${this.apiUrl}orden/registro/val/${id}`;
      return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
    }
}