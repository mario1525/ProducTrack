import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { labService } from 'src/app/shared/services/laboratorio.service';
import { lab } from 'src/types/laboratorios';

@Component({
  selector: 'app-laboratorios',
  templateUrl: './laboratorios.component.html',
  styleUrls: ['./laboratorios.component.less']
})
export class LaboratoriosComponent implements OnInit {
  IdCompania: string = "";
  Labs: lab[] = [];

  constructor(private route: Router, 
    private LabService : labService){

  }

  ngOnInit(): void {
    this.IdCompania = this.route.url.split('/')[3]   
    this.LabService.obtener_labs(this.IdCompania).subscribe({
     next: (Value) => {
       this.Labs = Value
       return; 
     },
     error: (error) => {
       console.log(error)
     }
   })
  }

   rediretdetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.Labs[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Laboratorio/${datosSeleccionados.id}`]);
  }

   homeback() {
    this.route.navigate(['App/Compania', this.IdCompania]);
    return
  }
  
   create() {
    this.route.navigate([`App/Compania/${this.IdCompania}/Laboratorio`]);
  }
}
