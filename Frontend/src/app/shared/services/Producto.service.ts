import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable } from 'rxjs';
import url from 'src/helpers/indexurl';
import { TokenserviceService } from './Token.service';
import { producto } from 'src/types/Producto'


@Injectable({
    providedIn: 'root'
  })
  export class productoService {
    private apiUrl = url; // Reemplaza con la URL real de tu backend
  constructor(private http: HttpClient, private auth:TokenserviceService ) { }

  obtener_Productos(id: string): Observable<producto[] | []> {    
    const url = `${this.apiUrl}api/Producto/${id}`;
    return this.http.get<producto[] | []>(url, { headers: { 'Authorization': `Bearer ${this.auth.getTokenFromCookie()}` }});    
  }
}