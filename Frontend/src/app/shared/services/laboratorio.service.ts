import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { lab } from 'src/types/laboratorios'


@Injectable({
    providedIn: 'root'
  })
  export class labService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Procesos(id: string): Observable<lab[] | []> {    
    const url = `${this.apiUrl}api/Lab/${id}`;
    return this.http.get<lab[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }
}