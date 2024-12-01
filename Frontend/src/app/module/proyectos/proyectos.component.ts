import { Component, OnInit } from '@angular/core';
import {Proyecto} from 'src/types/proyecto';
import { Router } from '@angular/router';
import { TokenserviceService } from '../../shared/services/Token.service';
import { ProyectoService } from 'src/app/shared/services/Proyecto.service';

@Component({
  selector: 'app-proyectos',
  templateUrl: './proyectos.component.html',
  styleUrls: ['./proyectos.component.less']
})
export class ProyectosComponent implements OnInit {  
  IdCompania: string = ""
  datos_Proyectos: Proyecto[] = [];  
  constructor(private route: Router, private ProyectoService : ProyectoService, private auth: TokenserviceService) {
  }

  ngOnInit(): void {    
    this.IdCompania = this.route.url.split('/')[3]  
    this.ProyectoService.obtener_proyectos(this.IdCompania).subscribe({
      next: (productos) => {
        this.datos_Proyectos = productos
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })
  }

  rediretdetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.datos_Proyectos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Proyecto/${datosSeleccionados.id}`]);
  }

   homeback() {
    this.route.navigate(['App/Compania', this.IdCompania]);
    return
  }
  
   create() {
    this.route.navigate([`App/Compania/${this.IdCompania}/Proyecto`]);
  }


}

