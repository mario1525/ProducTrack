import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { VistaCompania } from 'src/types/compania';


@Injectable({
    providedIn: 'root'
  })
  export class CompaniaService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_companias() {
    const url = `${this.apiUrl}/api/Compania`;
    return this.http.get<VistaCompania[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie().token}` } });    
  }
}
