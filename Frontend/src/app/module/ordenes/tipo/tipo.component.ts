import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { ordenService } from 'src/app/shared/services/Orden.service';

@Component({
  selector: 'app-tipo',
  templateUrl: './tipo.component.html',
  styleUrls: ['./tipo.component.less']
})
export class TipoComponent implements OnInit{

  Form: FormGroup;  
  
  //pop_Campo = false;
  idProyecto: string = "";
  idTipoOrden: string = "";  
  mostrar = false;

  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router,
    private Service: ordenService   
  ) {
  
    this.Form = this.fb.group({
      id: [''],
      nombre: ['', Validators.required], 
      descripcion: [''],      
      idProyecto: [''],        
      estado: [true],      
      fecha_log: ['']
    });  
    
  }

  ngOnInit(): void {  
    this.idProyecto = this.route.url.split('/')[5]   
      this.idTipoOrden = this.route.url.split('/')[7] 
      if(this.idProyecto){
        this.Service.obtener_t(this.idTipoOrden).subscribe({
          next: (value) => {
            this.Form.patchValue(value[0])  
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
      if(this.idTipoOrden){
        Value.idProyecto = this.idProyecto;
        this.Service.update_t(this.idTipoOrden,Value).subscribe({
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
        Value.idProyecto = this.idProyecto;         
                     
        this.Service.create_t(Value).subscribe({          
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
    this.Service.delete_t(this.idTipoOrden).subscribe({
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

}
