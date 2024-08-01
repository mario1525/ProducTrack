import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { producto, Camp, create_Product } from 'src/types/Producto'


@Injectable({
    providedIn: 'root'
  })
  export class productoService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Productos(id: string): Observable<producto[] | []> {    
    const url = `${this.apiUrl}api/Producto/Compania/${id}`;
    return this.http.get<producto[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener(id: string): Observable<producto[] | []> {    
    const url = `${this.apiUrl}api/Producto/${id}`;
    return this.http.get<producto[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create(Value: create_Product): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}api/Producto`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update(id: string, Value: producto): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}api/Producto/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}api/Producto/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  // campo

  obtener_c_Product(id: string): Observable<Camp[] | []> {    
    const url = `${this.apiUrl}api/Producto/Campo/${id}`;
    return this.http.get<Camp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_c(id: string): Observable<Camp[] | []> {    
    const url = `${this.apiUrl}api/Producto/Campo/Campo/${id}`;
    return this.http.get<Camp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create_c(Value: Camp): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}api/Producto/Campo`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update_c(id: string, Value: Camp): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}api/Producto/Campo/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete_c(id: string): Observable<{mensaje: string}> {
    const url = `${this.apiUrl}api/Producto/Campo/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }
}