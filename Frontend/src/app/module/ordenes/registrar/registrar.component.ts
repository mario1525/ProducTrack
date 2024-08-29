import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { oCampV, oCamp, create_Regis} from 'src/types/ordenes';

@Component({
  selector: 'app-registrar',
  templateUrl: './registrar.component.html',
  styleUrls: ['./registrar.component.less']
})
export class RegistrarComponent implements OnInit {
  Form: FormGroup;
  CampoForm: FormGroup;
  valores: oCampV[] = [];
  campos: oCamp[] = [];
  create_orden: create_Regis | undefined;
  //pop_Campo = false;
  idOrden: string = "";
  idROrden: string = "";
  idCompania: string = "";
  idCampo: string = "";
  mostrar = false;

  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router,
    private OrdenService: ordenService
  ){
    this.Form = this.fb.group({
      id: [''],
      idUsuario: ['', Validators.required],      
      idOrden: [''],      
      estado: [true],      
      fecha_log: ['']
    });
  
    this.CampoForm = this.fb.group({
      id: [''],
      valor: ['', Validators.required],
      idOrdenCamp: [''], 
      idRegisOrden: [''],                 
      fecha_log: ['']
    });
  }

  ngOnInit(): void {
    this.idCompania = this.route.url.split('/')[3] 
      this.idROrden = this.route.url.split('/')[6] 
      if(this.idROrden){
        this.OrdenService.obtenerR(this.idROrden).subscribe({
          next: (value) => {
            this.Form.patchValue(value[0])  
             this.idOrden = value[0].idOrden;
             this.OrdenService.obtener_c_orden(this.idOrden).subscribe({
              next: (Camp) => {
                this.campos = Camp                                     
                return; 
              },
              error: (error) => {
                console.log(error)
              }
            })                                  
            return;             
          },
          error: (error) => {
            console.log(error)
          }
        })
        
        this.OrdenService.obtener_ROrdenCV(this.idROrden).subscribe({
          next: (oCampV) => {
            this.valores = oCampV                                     
            return; 
          },
          error: (error) => {
            console.log(error)
          }
        })   
  
      }    
  }

}
