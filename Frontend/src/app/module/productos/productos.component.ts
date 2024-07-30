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
  IdCompania: string = ""
  datos_Productos: producto[] = [];  
  constructor(private route: Router, private productoservices : productoService, private auth: TokenserviceService) {
  }

  ngOnInit(): void {    
    this.IdCompania = this.route.url.split('/')[3]  
    this.productoservices.obtener_Productos(this.IdCompania).subscribe({
      next: (productos) => {
        this.datos_Productos = productos
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })
  }

  rediretdetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.datos_Productos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Producto/${datosSeleccionados.id}`]);
  }

   homeback() {
    this.route.navigate(['App/Compania', this.IdCompania]);
    return
  }
  
   create() {
    this.route.navigate([`App/Compania/${this.IdCompania}/Producto`]);
  }


}
