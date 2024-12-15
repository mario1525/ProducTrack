import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { ProyectoService } from 'src/app/shared/services/Proyecto.service';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { ordenTipo } from 'src/types/ordenes';


@Component({
  selector: 'app-proyecto',
  templateUrl: './proyecto.component.html',
  styleUrls: ['./proyecto.component.less']
})
export class ProyectoComponent implements OnInit{

  Form: FormGroup;  
  
  //pop_Campo = false;
  idProyecto: string = "";
  idCompania: string = "";  
  mostrar = false;
  ordenTipo : ordenTipo[] = [];

  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router,
    private Service: ProyectoService,
    private ServiceOrden: ordenService  
  ) {
  
    this.Form = this.fb.group({
      id: [''],
      nombre: ['', Validators.required], 
      descripcion: [''],      
      idCompania: [''],        
      estado: [true],      
      fecha_log: ['']
    });  
    
  }

  ngOnInit(): void {
    this.idCompania = this.route.url.split('/')[3] 
      this.idProyecto = this.route.url.split('/')[5] 
      if(this.idProyecto){
        this.Service.obtener_proyecto(this.idProyecto).subscribe({
          next: (value) => {
            this.Form.patchValue(value[0])  
            //console.log(value)                         
            return; 
          },
          error: (error) => {
            console.log(error)
          }
        }) 
        this.ServiceOrden.obtener_T_orden(this.idProyecto).subscribe({
          next: (value) => {
            this.ordenTipo = value  
            //console.log(value)                         
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
      const Value = this.Form.value      
      if(this.idProyecto){
        Value.idCompania = this.idCompania;
        this.Service.update_proyecto(this.idProyecto,Value).subscribe({
          next: () => {
            alert("Proyecto Actualizado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar el Proyecto');
          }
        })
      } else {   
        Value.idCompania = this.idCompania;         
                     
        this.Service.create_proyecto(Value).subscribe({          
          next: () => {
            alert("Proyecto creado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear el Proyecto');
          }
        })
      }        
    } else {
      alert("formulario invalido")
    }
  }  
  
  onDelete(): void {
    this.Service.delete_proyecto(this.idProyecto).subscribe({
      next: () => {
        alert("Proyecto eliminado")
        this.location.back();
      },
      error: (error) =>{
        console.log(error)
        alert('Error al eliminar el Proyecto');
      }
    })
  }

  CreateTipoO(): void {
    this.route.navigate([`App/Compania/${this.idCompania}/Proyecto/${this.idProyecto}/TipoOrden`]);
  }
  rediretTipo(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.ordenTipo[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.idCompania}/Proyecto/${this.idProyecto}/TipoOrden/${datosSeleccionados.id}`]);
  }

}

