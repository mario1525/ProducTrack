import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { Proceso } from 'src/types/procesos'


@Injectable({
    providedIn: 'root'
  })
  export class procesoService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Procesos(id: string): Observable<Proceso[] | []> {    
    const url = `${this.apiUrl}api/Proceso/${id}`;
    return this.http.get<Proceso[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }
}