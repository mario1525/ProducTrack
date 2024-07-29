import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { orden } from 'src/types/ordenes'

@Component({
  selector: 'app-ordenes',
  templateUrl: './ordenes.component.html',
  styleUrls: ['./ordenes.component.less']
})
export class OrdenesComponent implements OnInit {
  IdCompania: string = "";
  Ordenes: orden[] = [];

  constructor(private route: Router, 
    private ordenService : ordenService){

  }

  ngOnInit(): void {
    this.IdCompania = this.route.url.split('/')[3]   
    this.ordenService.obtener_Orden(this.IdCompania).subscribe({
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
    this.route.navigate([`App/Compania/${this.IdCompania}/Orden/${datosSeleccionados.id}`]);
  }

   homeback() {
    this.route.navigate(['App/Compania', this.IdCompania]);
    return
  }
  
   create() {
    this.route.navigate([`App/Compania/${this.IdCompania}/Orden`]);
  }

}
