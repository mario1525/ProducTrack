import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { orden } from 'src/types/ordenes'


@Injectable({
    providedIn: 'root'
  })
  export class ordenService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Orden(id: string): Observable<orden[] | []> {    
    const url = `${this.apiUrl}api/Orden/${id}`;
    return this.http.get<orden[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }
}