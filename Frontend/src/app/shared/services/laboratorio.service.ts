import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { create_Lab, lab, Camp } from 'src/types/laboratorios'


@Injectable({
    providedIn: 'root'
  })
  export class labService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_labs(id: string): Observable<lab[] | []> {    
    const url = `${this.apiUrl}api/Lab/Compania/${id}`;
    return this.http.get<lab[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener(id: string): Observable<lab[] | []> {    
    const url = `${this.apiUrl}api/Lab/${id}`;
    return this.http.get<lab[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create(Value: create_Lab): Observable<any> {
    const url = `${this.apiUrl}api/Lab`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update(id: string, Value: lab): Observable<any> {
    const url = `${this.apiUrl}api/Lab/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete(id: string): Observable<any> {
    const url = `${this.apiUrl}api/Lab/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  // campo

  obtener_c_lab(id: string): Observable<Camp[] | []> {    
    const url = `${this.apiUrl}api/Lab/Campo/${id}`;
    return this.http.get<Camp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_c(id: string): Observable<Camp[] | []> {    
    const url = `${this.apiUrl}api/Lab/Campo/Campo/${id}`;
    return this.http.get<Camp[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  create_c(Value: Camp): Observable<any> {
    const url = `${this.apiUrl}api/Lab/Campo`;
    return this.http.post<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  update_c(id: string, Value: Camp): Observable<any> {
    const url = `${this.apiUrl}api/Lab/Campo/${id}`;
    return this.http.put<{mensaje: string}>(url, Value, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

  delete_c(id: string): Observable<any> {
    const url = `${this.apiUrl}api/Lab/Campo/${id}`;
    return this.http.delete<{mensaje: string}>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});   
  }

}
