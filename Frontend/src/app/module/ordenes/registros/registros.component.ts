import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { regisOrden } from 'src/types/ordenes'

@Component({
  selector: 'app-registros',
  templateUrl: './registros.component.html',
  styleUrls: ['./registros.component.less']
})
export class RegistrosComponent implements OnInit {
  IdCompania: string = "";
  Ordenes: regisOrden[] = [];

  constructor(private route: Router, 
    private ordenService : ordenService){
  }

  ngOnInit(): void {
    this.IdCompania = this.route.url.split('/')[3]   
    this.ordenService.obtener_ROrdenCompania(this.IdCompania).subscribe({
     next: (Value) => {
       this.Ordenes = Value
       return; 
     },
     error: (error) => {
       console.log(error)
     }
   })
  }

  rediretdetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.Ordenes[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Registro/Orden/${datosSeleccionados.id}`]);
  }  
  
   create() {
    this.route.navigate([`App/Compania/${this.IdCompania}/Registro/Orden`]);
  }

}
