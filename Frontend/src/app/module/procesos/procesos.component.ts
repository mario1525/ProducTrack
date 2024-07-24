import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Proceso } from 'src/types/procesos';
import { procesoService } from 'src/app/shared/services/Proceso.service';
import { TokenserviceService } from '../../shared/services/Token.service';

@Component({
  selector: 'app-procesos',
  templateUrl: './procesos.component.html',
  styleUrls: ['./procesos.component.less']
})
export class ProcesosComponent implements OnInit {
  Procesos: Proceso[] = [];
  IdCompania: string = "";
  constructor(private route: Router, private procesoService : procesoService , private auth: TokenserviceService) {
  }

  ngOnInit(): void {
    this.IdCompania = this.route.url.split('/')[3]   
    this.procesoService.obtener_Procesos(this.IdCompania).subscribe({
     next: (Proceso) => {
       this.Procesos = Proceso
       return; 
     },
     error: (error) => {
       console.log(error)
     }
   })   
  }

  public redireProcesodetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.Procesos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Proceso/${datosSeleccionados.id}`]);
  }

  public homeback() {
    this.route.navigate(['App/Compania', this.IdCompania]);
    return
  }
  
  public createProceso() {
    this.route.navigate([`/App/Compania/${this.IdCompania}/Proceso`]);
  }

}
