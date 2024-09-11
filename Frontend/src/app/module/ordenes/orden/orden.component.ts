import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { oCamp, create_orden} from 'src/types/ordenes';

@Component({
  selector: 'app-orden',
  templateUrl: './orden.component.html',
  styleUrls: ['./orden.component.less']
})
export class OrdenComponent implements OnInit {
Form: FormGroup;
CampoForm: FormGroup;
campos: oCamp[] = [];
create_orden: create_orden | undefined;
//pop_Campo = false;
idOrden: string = "";
idCompania: string = "";
idCampo: string = "";
mostrar = false;



constructor(
  private fb: FormBuilder,
  private location: Location,   
  private route: Router,
  private OrdenService: ordenService
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
    obligatorio: [true],          
    idOrden: [''],      
    estado: [true],            
    fecha_log: ['']
  });
}
ngOnInit(): void {
  this.idCompania = this.route.url.split('/')[3] 
    this.idOrden = this.route.url.split('/')[5] 
    if(this.idOrden){
      this.OrdenService.obtener(this.idOrden).subscribe({
        next: (value) => {
          this.Form.patchValue(value[0])  
          console.log(value)                         
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })
      this.OrdenService.obtener_c_orden(this.idOrden).subscribe({
        next: (etapas) => {
          this.campos = etapas                                     
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
    if(this.idOrden){
      Value.idCompania = this.idCompania;
      this.OrdenService.update(this.idOrden,Value).subscribe({
        next: () => {
          alert("Orden Actualizada")
          this.location.back();
        },
        error: (error) =>{
          console.log(error)
          alert('Error al actualizar la orden');
        }
      })
    } else {   
      Value.idCompania = this.idCompania;
      this.create_orden =  {
        orden: Value,
        campos: this.campos
      }                     
      this.OrdenService.create(this.create_orden).subscribe({          
        next: () => {
          alert("orden creada")
          this.location.back();
        },
        error: (error) =>{
          console.log(error)
          alert('Error al crear la orden');
        }
      })
    }        
  } else {
    alert("formulario invalido")
  }
}

redirecCamp(indice: number): void {
  const datosSeleccionados = this.campos[indice]; 
    this.OrdenService.obtener_c(datosSeleccionados.id).subscribe({
      next: (Etapa) => {
        this.idCampo = datosSeleccionados.id
        this.mostrar = true
        this.CampoForm.patchValue(Etapa[0])                   
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
    this.OrdenService.delete_c(datosSeleccionados.id).subscribe({
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
    if(this.idOrden){
      const Value = this.CampoForm.value
      if(this.idCampo){
        this.OrdenService.update_c(this.idCampo,Value).subscribe({
          next: () => {
            alert("Campo actualizada") 
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
        Value.idOrden = this.idOrden        
        this.OrdenService.create_c(Value).subscribe({
          next: () => {
            alert("campo creado")
            this.limpiar()
            this.ngOnInit()
            this.mostrar = false
            
            //this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear la etapa');
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

cerrarPopup(): void {
  //this.pop_Campo = false;
  this.ngOnInit()
}

onDelete(): void {
  this.OrdenService.delete(this.idOrden).subscribe({
    next: () => {
      alert("orden eliminada")
      this.location.back();
    },
    error: (error) =>{
      console.log(error)
      alert('Error al eliminar la orden');
    }
  })
} 

}


