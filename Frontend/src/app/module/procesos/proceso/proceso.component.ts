import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Etapa, Proceso } from 'src/types/procesos'
import { procesoService } from 'src/app/shared/services/Proceso.service'
import { TokenserviceService } from '../../../shared/services/Token.service';
import { Location } from '@angular/common';


@Component({
  selector: 'app-proceso',
  templateUrl: './proceso.component.html',
  styleUrls: ['./proceso.component.less']
})
export class ProcesoComponent implements OnInit {
  ProcesForm: FormGroup;
  Proceso: Proceso | undefined;
  etapas: Etapa[]  = [];
  idProceso: string = "";
  idCompania: string = "";

  constructor(
    private fb: FormBuilder,
    private location: Location,
    private auth: TokenserviceService, 
    private route: Router,
    private procesoService: procesoService
  ) {
    this.ProcesForm = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],      
      idCompania: [ ''],      
      estado: [''],      
      fecha_log: ['']
    });    
  }

  ngOnInit(): void {
    this.idCompania = this.route.url.split('/')[3] 
    this.idProceso = this.route.url.split('/')[5] 
    if(this.idProceso){
      this.procesoService.obtener(this.idProceso).subscribe({
        next: (Proceso) => {
          this.ProcesForm.patchValue(Proceso[0])                           
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })
      this.procesoService.obtener_etapas_Procesos(this.idProceso).subscribe({
        next: (etapas) => {
          this.etapas = etapas                           
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })

    }
  }

  onSubmit(): void {
    if (this.ProcesForm.valid) {        
      let Value = this.ProcesForm.value      
      if(this.idProceso){
        this.procesoService.update(this.idProceso,Value).subscribe({
          next: () => {
            alert("Proceso Actualizado actualizada")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar el usuario');
          }
        })
      } else {   
        Value.idCompania = this.idCompania;                  
        this.procesoService.create(Value).subscribe({          
          next: () => {
            alert("usuario creado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear el proceso');
          }
        })
      }        
    } else {
      alert("formulario invalido")
    }
  }

  onDelete(): void {
    this.procesoService.delete(this.idProceso).subscribe({
      next: () => {
        alert("Proceso eliminado")
        this.location.back();
      },
      error: (error) =>{
        console.log(error)
        alert('Error al eliminar el Proceso');
      }
    })
  } 
}
