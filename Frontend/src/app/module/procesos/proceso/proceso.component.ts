import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Etapa, Proceso, create_Proces } from 'src/types/procesos'
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
  create_proces: create_Proces | undefined; 
  pop_etapa = false;
  Proceso: Proceso | undefined;
  etapas: Etapa[]  = [];
  idProceso: string = "";
  idCompania: string = "";
  idEtapa: string = "";
  etapaForm: FormGroup;
  mostrar = false;

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
      idCompania: [''],      
      estado: [''],      
      fecha_log: ['']
    });

    this.etapaForm = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],
      nEtapa: ['', Validators.required],           
      idProceso: [''],      
      estado: [true],            
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
            alert("Proceso Actualizado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar el proceso');
          }
        })
      } else {   
        Value.idCompania = this.idCompania;
        this.create_proces =  {
          process: Value,
          procesEtaps: this.etapas
        }  
        //console.log(this.create_proces)               
        this.procesoService.create(this.create_proces).subscribe({          
          next: () => {
            alert("Proceso creado")
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

  public redirecEtapa(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.etapas[indice];
    this.idEtapa = datosSeleccionados.id
    this.pop_etapa = true
    // Realiza la redirección con los datos específicos
    
  }

  createEtapa(): void{
    if(this.idProceso){
      this.pop_etapa = true      
    }else{
      this.mostrar = true
    }
    
  }

  onDeleteEtapa(indice: number): void {
    const datosSeleccionados = this.etapas[indice];
    this.procesoService.delete_etapa(datosSeleccionados.id).subscribe({
      next: () => {
        alert("etapa eliminada")
        this.ngOnInit()
        //this.location.back();
      },
      error: (error) =>{
        console.log(error)
        alert('Error al eliminar la etapa');
      }
    })
  } 

  public limpiar() {
    this.etapaForm.reset();
  }

  public agregar_Etapa() {
    if (this.etapaForm.valid) {
      this.etapas.push(this.etapaForm.value);  
      //console.log(this.etapas)         
      this.mostrar = false
      this.limpiar();
      return;
    }
    alert('Formulario inválido, por favor revisa los datos ingresados');
    return;
  }

  
  cerrarPopup(): void {
    this.pop_etapa   = false;
    this.ngOnInit()
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
