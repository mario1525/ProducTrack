import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { Camp, create_Lab } from 'src/types/laboratorios';
import { labService } from 'src/app/shared/services/laboratorio.service';

@Component({
  selector: 'app-laboratorio',
  templateUrl: './laboratorio.component.html',
  styleUrls: ['./laboratorio.component.less']
})
export class LaboratorioComponent implements OnInit {

  Form: FormGroup;
  CampoForm: FormGroup;
  campos: Camp[] = [];
  create_Lab: create_Lab | undefined;
  //pop_Campo = false;
  idLab: string = "";
  idCompania: string = "";
  idCampo: string = "";
  mostrar = false;

  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router,
    private Service: labService
  ) {
  
    this.Form = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],      
      idCompania: [''],      
      estado: [true],      
      fecha_log: ['']
    });
  
    this.CampoForm = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],
      tipoDato: ['', Validators.required], 
      unidadMedida: ['', Validators.required],                 
      idLab: [''],      
      estado: [true],            
      fecha_log: ['']
    });
  }

  ngOnInit(): void {
    this.idCompania = this.route.url.split('/')[3] 
      this.idLab = this.route.url.split('/')[5] 
      if(this.idLab){
        this.Service.obtener(this.idLab).subscribe({
          next: (value) => {
            this.Form.patchValue(value[0])  
            //console.log(value)                         
            return; 
          },
          error: (error) => {
            console.log(error)
          }
        })
        this.Service.obtener_c_lab(this.idLab).subscribe({
          next: (Campos) => {
            this.campos = Campos                                     
            return; 
          },
          error: (error) => {
            console.log(error)
          }
        })
  
      }
    
  }

  onSubmit(): void {
    if (this.Form.valid) {        
      let Value = this.Form.value      
      if(this.idLab){
        Value.idCompania = this.idCompania;
        this.Service.update(this.idLab,Value).subscribe({
          next: () => {
            alert("laboratorio Actualizado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar el laboratorio');
          }
        })
      } else {   
        Value.idCompania = this.idCompania;
        this.create_Lab =  {
          lab: Value,
          campos: this.campos
        }  
        //console.log(this.create_Lab)               
        this.Service.create(this.create_Lab).subscribe({          
          next: () => {
            alert("Laboratorio creado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear el laboratorio');
          }
        })
      }        
    } else {
      alert("formulario invalido")
    }
  }
  
  redirecCamp(indice: number): void {
    const datosSeleccionados = this.campos[indice]; 
      this.Service.obtener_c(datosSeleccionados.id).subscribe({
        next: (Campo) => {
          this.idCampo = datosSeleccionados.id
          this.mostrar = true
          this.CampoForm.patchValue(Campo[0])                   
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })    
  }
  
  
  createCamp(): void{ 
      this.mostrar = true  
  }
  
  onDeleteCamp(indice: number): void {
    const datosSeleccionados = this.campos[indice];
      this.Service.delete_c(datosSeleccionados.id).subscribe({
        next: () => {
          alert("campo eliminadao")
          this.ngOnInit()
          //this.location.back();
        },
        error: (error) =>{
          console.log(error)
          alert('Error al eliminar el campo');
        }
      })
  }
  
  limpiar() {
    this.CampoForm.reset();
  }
  
  agregar_Camp() {
    if (this.CampoForm.valid) {
      if(this.idLab){
        let Value = this.CampoForm.value        
        if(this.idCampo){
          console.log(Value)
          this.Service.update_c(this.idCampo,Value).subscribe({
            next: () => {
              alert("Campo actualizado") 
              this.limpiar();  
              this.idCampo = ""
              this.ngOnInit()
              this.mostrar = false        
              //this.location.back();
            },
            error: (error) =>{
              console.log(error)  
              alert('Error al actualizar el campo');
            }
          })
        } else {
          Value.idLAb = this.idLab       
          this.Service.create_c(Value).subscribe({
            next: () => {
              alert("campo creado")
              this.limpiar
              this.ngOnInit()
              this.mostrar = false
              
              //this.location.back();
            },
            error: (error) =>{
              console.log(error)
              alert('Error al crear el campo');
            }
          })
        }
      }else {
      this.campos.push(this.CampoForm.value);  
      //console.log(this.etapas)         
      this.mostrar = false
      this.limpiar();
      return;
      }
    } else {
      alert('Formulario inválido, por favor revisa los datos ingresados');
      return;
    } 
  }
  
  
  onDelete(): void {
    this.Service.delete(this.idLab).subscribe({
      next: () => {
        alert("producto eliminado")
        this.location.back();
      },
      error: (error) =>{
        console.log(error)
        alert('Error al eliminar el laboratorio');
      }
    })
  }

}
