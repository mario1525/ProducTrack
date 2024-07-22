import { Component, OnInit } from '@angular/core';
import {producto} from 'src/types/Producto';
import { Router } from '@angular/router';
import { TokenserviceService } from '../../shared/services/Token.service';
import { productoService } from 'src/app/shared/services/Producto.service';

@Component({
  selector: 'app-productos',
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.less']
})
export class ProductosComponent implements OnInit {
  opciones = false
  datos_Productos: producto[] = [];
  navRoutes = [
    //{ path: '/App/Companias', label: 'Compania' },
    { path: '/App/Usuarios', label: 'Usuarios' },
    //{ path: '/App/Productos', label: 'Productos' },
    { path: '/App/Procesos', label: 'Procesos' },
    { path: '/App/Ordenes', label: 'Ordenes' },
    { path: '/App/Laboratorios', label: 'Laboratorios' }
  ];
  constructor(private route: Router, private productoservices : productoService, private auth: TokenserviceService) {
  }

  ngOnInit(): void {    
    //console.log(this.auth.decodetoken(this.auth.getTokenFromCookie()).IdCompania);
    this.productoservices.obtener_Productos(this.auth.decodetoken(this.auth.getTokenFromCookie()).IdCompania).subscribe({
      next: (productos) => {
        this.datos_Productos = productos
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })
  }


}
