import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { procesoService } from 'src/app/shared/services/Proceso.service';
import { productoService } from 'src/app/shared/services/Producto.service';
import { Camp, create_Product} from 'src/types/Producto';
import { Proceso } from 'src/types/procesos'

@Component({
  selector: 'app-producto',
  templateUrl: './producto.component.html',
  styleUrls: ['./producto.component.less']
})
export class ProductoComponent implements OnInit{

  Form: FormGroup;
  CampoForm: FormGroup;
  campos: Camp[] = [];
  procesos: Proceso[] = [];
  create_Product: create_Product | undefined;
  //pop_Campo = false;
  idProduct: string = "";
  idCompania: string = "";
  idCampo: string = "";
  mostrar = false;

  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router,
    private Service: productoService,
    private ProcesoService: procesoService
  ) {
  
    this.Form = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],      
      idCompania: [''],
      idProceso: [''],    
      estado: [true],      
      fecha_log: ['']
    });
  
    this.CampoForm = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],
      tipoDato: ['', Validators.required], 
      obligatorio: ['', Validators.required],                 
      idProduct: [''],      
      estado: [true],            
      fecha_log: ['']
    });
  }

  ngOnInit(): void {
    this.idCompania = this.route.url.split('/')[3] 
      this.idProduct = this.route.url.split('/')[5] 
      if(this.idProduct){
        this.Service.obtener(this.idProduct).subscribe({
          next: (value) => {
            this.Form.patchValue(value[0])  
            //console.log(value)                         
            return; 
          },
          error: (error) => {
            console.log(error)
          }
        })
        this.Service.obtener_c_Product(this.idProduct).subscribe({
          next: (Campos) => {
            this.campos = Campos                                     
            return; 
          },
          error: (error) => {
            console.log(error)
          }
        })        
      } 
      this.ProcesoService.obtener_Procesos(this.idCompania).subscribe({
        next: (Campos) => {
          this.procesos = Campos                                     
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })    
  }

  onSubmit(): void {
    if (this.Form.valid) {        
      let Value = this.Form.value      
      if(this.idProduct){
        Value.idCompania = this.idCompania;
        this.Service.update(this.idProduct,Value).subscribe({
          next: () => {
            alert("Producto Actualizado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar el Producto');
          }
        })
      } else {   
        Value.idCompania = this.idCompania;
        this.create_Product =  {
          producto: Value,
          campos: this.campos
        }  
        console.log(this.create_Product)               
        this.Service.create(this.create_Product).subscribe({          
          next: () => {
            alert("Producto creado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear el Producto');
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
      if(this.idProduct){
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
          Value.idProduct = this.idProduct      
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
    this.Service.delete(this.idProduct).subscribe({
      next: () => {
        alert("producto eliminado")
        this.location.back();
      },
      error: (error) =>{
        console.log(error)
        alert('Error al eliminar el Producto');
      }
    })
  }

}
