import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { orden, create_orden, oCamp } from 'src/types/ordenes'


@Injectable({
    providedIn: 'root'
  })
  export class ordenService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Orden(id: string): Observable<orden[] | []> {    
    const url = `${this.apiUrl}api/Orden/Compania/${id}`;
    return this.http.get<orden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener(id: string): Observable<orden[] | []> {    
    const url = `${this.apiUrl}api/Orden/${id}`;
    return this.http.get<orden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create(Value: create_orden): Observable<any> {
    const url = `${this.apiUrl}api/Orden`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update(id: string, Value: orden): Observable<any> {
    const url = `${this.apiUrl}api/Orden/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete(id: string): Observable<any> {
    const url = `${this.apiUrl}api/Orden/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  // campo

  obtener_c_orden(id: string): Observable<oCamp[] | []> {    
    const url = `${this.apiUrl}api/Orden/Campo/${id}`;
    return this.http.get<oCamp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_c(id: string): Observable<oCamp[] | []> {    
    const url = `${this.apiUrl}api/Orden/Campo/Campo/${id}`;
    return this.http.get<oCamp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create_c(Value: oCamp): Observable<any> {
    const url = `${this.apiUrl}api/Orden/Campo`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update_c(id: string, Value: oCamp): Observable<any> {
    const url = `${this.apiUrl}api/Orden/Campo/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete_c(id: string): Observable<any> {
    const url = `${this.apiUrl}api/Orden/Campo/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

}