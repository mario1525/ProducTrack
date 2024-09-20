import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormControl, Validators} from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { UsuarioService } from 'src/app/shared/services/usuarios.service';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { productoService } from 'src/app/shared/services/Producto.service';
import { oCampV, oCamp, orden, create_Regis } from 'src/types/ordenes';
import { Usuario } from 'src/types/usuarios';
import { Regisproducto } from 'src/types/Producto';

@Component({
  selector: 'app-registrar',
  templateUrl: './registrar.component.html',
  styleUrls: ['./registrar.component.less']
})
export class RegistrarComponent implements OnInit {
  formReady: boolean = false;
  Form: FormGroup;
  CampoForm: FormGroup;
  valores: oCampV[] = [];
  productos: Regisproducto[] = [];
  campos: oCamp[] = [];
  create_orden: create_Regis | undefined;
  supervisores: Usuario[] = []
  ordenes: orden[] = [];  
  idOrden: string = "";
  idROrden: string = "";
  idCompania: string = "";


  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router,
    private OrdenService: ordenService,
    private ProductoService: productoService,
    private UsuarioService: UsuarioService
  ) {
    this.Form = this.fb.group({
      id: [''],
      idUsuario: ['', Validators.required],
      idCompania: [''],      
      idOrden: ['', Validators.required],      
      estado: [true],      
      fecha_log: ['']
    });
  
    this.CampoForm = this.fb.group({});
  }

  ngOnInit(): void {
    this.idCompania = this.route.url.split('/')[3];
    this.idROrden = this.route.url.split('/')[6];

    if (this.idROrden) {
      // Obtener la información del registro
      this.OrdenService.obtenerR(this.idROrden).subscribe({
        next: (value) => {
          this.Form.patchValue(value[0]);
          this.idOrden = value[0].idOrden;

          // Obtener la información de los campos
          this.OrdenService.obtener_c_orden(this.idOrden).subscribe({
            next: (Camp) => {
              this.campos = Camp;

              // Obtener los valores de los campos
              this.OrdenService.obtener_ROrdenCV(this.idROrden).subscribe({
                next: (oCampV) => {
                  this.valores = oCampV;
                    // Después de agregar los controles en ngOnInit o en la suscripción
                    this.campos.forEach(campo => {
                      const valorInicial = this.getValorPorCampo(campo.id)?.valor || '';                    
                      this.CampoForm.addControl(campo.id, new FormControl(valorInicial, Validators.required));
                    });
                    this.formReady = true; // Los controles están listos
                },
                error: (error) => {
                  console.log(error);
                }
              });
            },
            error: (error) => {
              console.log(error);
            }
          });
        },
        error: (error) => {
          console.log(error);
        }
      });
    }

    // Obtener las órdenes
    this.OrdenService.obtener_Orden(this.idCompania).subscribe({
      next: (value) => {
        this.ordenes = value;
      },
      error: (error) => {
        console.log(error);
      }
    });

    // Obtener los Producto asociados a esa orden
    this.ProductoService.obtener_RProductOrden(this.idROrden).subscribe({
      next: (value) => {
        this.productos = value;
      },
      error: (error) => {
        console.log(error);
      }
    });

    // Obtener supervisores
    this.UsuarioService.obtener_Supervisores(this.idCompania).subscribe({
      next: (value) => {
        this.supervisores = value;
      },
      error: (error) => {
        console.log(error);
      }
    });
  }

  // Relaciona los valores con los campos 
  getValorPorCampo(campoId: string): oCampV | undefined {    
    return this.valores.find(val => val.idOrdenCamp === campoId);
  }
  
  // Post o update a un registro 
  onSubmit(): void {
    if (this.Form.valid) {            
      if(this.idROrden){  
        // Llamar al servicio para crear la orden
        const formValue = this.Form.value;                     
        // Actualizar los valores con los datos del CampoForm
        this.valores.forEach(valor => {
          const campoFormControl = this.CampoForm.get(valor.idOrdenCamp); // Busca el FormControl por el id del campo
          if (campoFormControl) {
            valor.valor = campoFormControl.value;  // Actualiza el valor de la lista de valores
          }
        });
        // Crear el objeto de la orden con los campos y sus valores
        this.create_orden = {
          orden: formValue,
          campos: this.valores  // Pasar los campos con valores
        };                 
        // hacer la llamada a la api 
        this.OrdenService.updateR(this.idROrden,this.create_orden).subscribe({
          next: () => {
            alert("Orden Actualizada")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar la orden');
          }
        })             
      }else{
      // Llamar al servicio para crear la orden
      const formValue = this.Form.value; 
       formValue.idCompania = this.idCompania; 
      // Construir el objeto con los campos y sus valores
      const camposConValores: oCampV[] = this.campos.map(campo => {
        const valorCampo = this.CampoForm.get(campo.id)?.value || '';  // Obtener el valor de cada campo desde el formulario
        return {
          id: '',  // Asignar un ID único o dejar en blanco si se genera en el backend
          valor: valorCampo,  // El valor ingresado en el formulario
          idOrdenCamp: campo.id,  // El ID del campo
          idRegisOrden: "",  // Asignar el ID de la orden actual
          fecha_log: ""  // Usar la fecha actual o ajustarla según el caso
        };
      });       
      // Crear el objeto de la orden con los campos y sus valores
      this.create_orden = {
        orden: formValue,
        campos: camposConValores  // Pasar los campos con valores
      }; 
      // hacer la llamda al api
      //  POST
      // crear el registro  
      this.OrdenService.createR(this.create_orden).subscribe({
        next: () => {
          alert("Orden creada");
          this.location.back();
        },
        error: (error) => {
          console.log(error);
          alert('Error al crear la orden');
        }
      });
      }      
    } else {
      alert("Formulario inválido");
    }
  }
  
  // Eliminar un registro delete
  onDelete(): void {
    this.OrdenService.deleteR(this.idROrden).subscribe({
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

  // Obtiene el control del campo
  getControl(campoId: string): FormControl {
    return this.CampoForm.get(campoId) as FormControl;
  }
  
  // Carga los campos al momento de seleccionar un tipo de orden 
  updateCamp(): void {
    const value = this.Form.value.idOrden;
    this.OrdenService.obtener_c_orden(value).subscribe({
      next: (Camp) => {
        this.campos = Camp;
        // Después de agregar los controles en ngOnInit o en la suscripción
        this.campos.forEach(campo => {
          const valorInicial = this.getValorPorCampo(campo.id)?.valor || '';                    
          this.CampoForm.addControl(campo.id, new FormControl(valorInicial, Validators.required));
        });
        this.formReady = true; // Los controles están listos
      },
      error: (error) => {
        console.log(error);
      }
    });    
  }  
  
  // redirigir a un registro de un producto
  rediretdetalle(indice: number): void {
    // Accede a los datos específicos de la fila actual
    const datosSeleccionados = this.productos[indice];
  
    // Realiza la redirección con los datos específicos
    this.route.navigate([`App/Compania/${this.idCompania}/Registro/Producto/${datosSeleccionados.id}`]);
  }  
   
   // Registrar un nuevo producto 
   create() {
    this.route.navigate([`App/Compania/${this.idCompania}/Registro/Producto`]);
  }
  
}
