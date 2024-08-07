import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { VistaCompania } from 'src/types/compania';
import { TokenserviceService } from '../../shared/services/Token.service';
import { CompaniaService } from 'src/app/shared/services/Compania.service';


@Component({
  selector: 'app-compania',
  templateUrl: './compania.component.html',
  styleUrls: ['./compania.component.less']
})
export class CompaniaComponent implements OnInit {  
  opciones = false
  datos_Companias: VistaCompania[] = [];  
  constructor(private route: Router, private CompaniaService : CompaniaService , private auth: TokenserviceService) {
  }
    ngOnInit(): void {
    this.CompaniaService.obtener_companias().subscribe({
      next: (Companias) => {
        this.datos_Companias = Companias
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })
  } 

  public redirecCompaniadetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.datos_Companias[indice];

    // Realiza la redirección con los datos específicos
    this.route.navigate(['App/Compania', datosSeleccionados.id]);
  }
  public homeback() {
    this.route.navigate(['App/Companias']);
    return
  }

  

  public createCompania() {
    this.route.navigate(['App/Compania']);
  }  
}
