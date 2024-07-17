import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { VistaCompania, Compania } from 'src/types/compania';


@Injectable({
    providedIn: 'root'
  })
  export class CompaniaService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_companias(): Observable<VistaCompania[] | []> {    
    const url = `${this.apiUrl}api/Compania`;
    return this.http.get<VistaCompania[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }

  obtener_compania(id: string ): Observable<Compania> {    
    const url = `${this.apiUrl}api/Compania/${id}`;
    return this.http.get<Compania>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }
}
