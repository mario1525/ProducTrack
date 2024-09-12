import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { productoService } from 'src/app/shared/services/Producto.service';
import { Regisproducto } from 'src/types/Producto'

@Component({
  selector: 'app-registros-producto',
  templateUrl: './registros-producto.component.html',
  styleUrls: ['./registros-producto.component.less']
})
export class RegistrosProductoComponent implements OnInit {
  IdCompania: string = "";
  Productos: Regisproducto[] = [];

  constructor(private route: Router, 
    private productoService : productoService){
  }

  ngOnInit(): void {
    this.IdCompania = this.route.url.split('/')[3]   
    this.productoService.obtener_RProductC(this.IdCompania).subscribe({
     next: (Value) => {
       this.Productos = Value
       return; 
     },
     error: (error) => {
       console.log(error)
     }
   })
  }

  rediretdetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.Productos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Registro/Producto/${datosSeleccionados.id}`]);
  }  
  
   create() {
    this.route.navigate([`App/Compania/${this.IdCompania}/Registro/Producto`]);
  }

}

