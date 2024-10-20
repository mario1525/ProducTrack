import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup} from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { ordenService } from 'src/app/shared/services/Orden.service';

@Component({
  selector: 'app-etapa-orden',
  templateUrl: './etapa-orden.component.html',
  styleUrls: ['./etapa-orden.component.less']
})
export class EtapaOrdenComponent  implements OnInit {
  Form: FormGroup;
  idROrden: string = "";
  idProcesEtap: string = "";

  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router, 
    private OrdenService: ordenService

  ) {
  
  this.Form = this.fb.group({
    id: [''],
    idRegisOrden: [''],      
    idProcesEtap: [''], 
    idUsuario: [''],      
    estado: [true],      
    fecha_log: ['']
  });
}

ngOnInit(): void {  
  this.idROrden = this.route.url.split('/')[6] 
  this.idProcesEtap = this.route.url.split('/')[8]
  if(this.idProcesEtap){
    this.OrdenService.obtener_DetalleEtapa(this.idROrden,this.idProcesEtap).subscribe({
      next: (value) => {
        this.Form.patchValue(value[0])  
        console.log(value)                         
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })
  }
}

}
