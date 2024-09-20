import { Component, OnInit  } from '@angular/core';
import { Router } from '@angular/router';
import { Compania } from 'src/types/compania';
import { producto } from 'src/types/Producto';
import { lab } from 'src/types/laboratorios';
import { orden } from 'src/types/ordenes';
import { Proceso } from 'src/types/procesos';
import { TokenserviceService } from '../../../shared/services/Token.service';
import { CompaniaService } from 'src/app/shared/services/Compania.service';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { procesoService } from 'src/app/shared/services/Proceso.service';
import { productoService } from 'src/app/shared/services/Producto.service';
import { labService } from 'src/app/shared/services/laboratorio.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';


@Component({
  selector: 'app-detallecompania',
  templateUrl: './detallecompania.component.html',
  styleUrls: ['./detallecompania.component.less']
})
export class DetallecompaniaComponent implements OnInit {
  CompaniaForm: FormGroup;  
  IdCompania: string = "";
  Compania: Compania | undefined;
  procesos: Proceso[] = [];
  laboratorios: lab[] = [];
  ordenes: orden[] = [];
  productos: producto[] = [];
  navRoutes = [ 
    { path: 'App/Compania/:id/Usuarios', label: 'Usuarios' },
    { path: 'App/Compania/:id/Productos', label: 'Productos' },
    { path: 'App/Compania/:id/Procesos', label: 'Procesos' },
    { path: 'App/Compania/:id/Ordenes', label: 'Ordenes' },    
    { path: 'App/Compania/:id/Laboratorios', label: 'Laboratorios' },
    { path: 'App/Compania/:id/Registros/Productos', label: 'Registros Productos' },
    { path: 'App/Compania/:id/Registros/Ordenes', label: 'Registros Ordenes' },
  ];
  constructor(
     private route: Router,
     private procesoService : procesoService, 
     private productoService : productoService, 
     private labService : labService, 
     private CompaniaService : CompaniaService, 
     private ordenService : ordenService ,
     private auth: TokenserviceService, 
     private fb: FormBuilder,
    ) {
      this.CompaniaForm = this.fb.group({
        id:[''],
        nombre: ['', [Validators.required, Validators.minLength(3)]],
        nit: ['', [Validators.required, Validators.min(100)]],
        ciudad: ['', [Validators.required, Validators.minLength(3)]],
        direccion: ['', [Validators.required, Validators.minLength(8)]],
        sector: ['', [Validators.required, Validators.minLength(8)]],        
        estado:[true],
        fecha_log: ['']
      })
  }

  ngOnInit(): void {    
    this.IdCompania = this.route.url.split('/')[3]     
    if(this.IdCompania){
      this.CompaniaService.obtener_compania(this.IdCompania).subscribe({
        next: (Compania) => {
          this.CompaniaForm.patchValue(Compania[0])
          this.Compania = Compania[0]          
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })    
  
      this.procesoService.obtener_Procesos(this.IdCompania).subscribe({
        next: (Procesos) => {
          this.procesos = Procesos
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })
  
      this.ordenService.obtener_Orden(this.IdCompania).subscribe({
        next: (ordenes) => {
          this.ordenes = ordenes
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })
  
      this.productoService.obtener_Productos(this.IdCompania).subscribe({
        next: (productos) => {
          this.productos = productos
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })
  
      this.labService.obtener_labs(this.IdCompania).subscribe({
        next: (laboratorios) => {
          this.laboratorios = laboratorios
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })
    }    
  } 

  onSubmit(): void {
    if(this.CompaniaForm.valid){
      const compania = this.CompaniaForm.value   
        
      if(this.IdCompania){
        this.CompaniaService.update_compania(this.IdCompania,compania).subscribe({
          next: () => {
            alert("compania actualizada")
            this.route.navigate(['/App/Companias']);
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar la compania');
          }
        })
      } else {
        this.CompaniaService.create_compania(compania).subscribe({
          next: () => {
            alert("compania creada")
            this.route.navigate(['/App/Companias']);
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear la compania');
          }
        })
      }   
    }else {
      alert("formulario invalido")
    }
  }

  delete_compania(): void { 
    if(this.auth.decodetoken(this.auth.getTokenFromCookie()).Rol == 'Admin'){
      const id = this.route.url.split('/')[3]
      this.CompaniaService.delete_compania(id).subscribe({
        next: () => {
          alert("compania eliminada")
          this.route.navigate(['/App/Companias']);
        },
        error: (error) =>{
          console.log(error)
          alert('Error al eliminar la compania');
        }
      })
    } else {
      alert("el usuario no tiene permisos necesarios para estra accion")
    }     
  } 
   
  // para laboratorios
  createLab(){
    this.route.navigate([`App/Compania/${this.IdCompania}/Laboratorio`]);
    return
  }
  rediretLab(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.productos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Laboratorio/${datosSeleccionados.id}`]);
  }

  // para ordenes 
  createOrden(){
    this.route.navigate([`App/Compania/${this.IdCompania}/Orden`]);
    return
  }
  rediretOrden(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.productos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Orden/${datosSeleccionados.id}`]);
  }

  // para procesos
  createProceso(){
    this.route.navigate([`App/Compania/${this.IdCompania}/Proceso`]);
    return
  }
  rediretProceso(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.productos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Proceso/${datosSeleccionados.id}`]);
  }

  // para Producto
  createProduct(){
    this.route.navigate([`App/Compania/${this.IdCompania}/Producto`]);
    return
  }
  rediretProduct(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.productos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.IdCompania}/Producto/${datosSeleccionados.id}`]);
  }

  public homeback() {
    this.route.navigate(['App/Home']);
    return
  }
  
  public cerrarsession() {
    //localStorage.removeItem('token')
    this.auth
      .removeTokenFromCookie()
      .then(() => {
        this.route.navigate(['login']);
      })
      .catch((error) => {
        console.log(error);
        alert('Error al eliminar la cookie');
      });

    return;
  }
}
