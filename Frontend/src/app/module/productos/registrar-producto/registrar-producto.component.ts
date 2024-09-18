import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormControl, Validators} from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { UsuarioService } from 'src/app/shared/services/usuarios.service';
import { Regisproducto, Camp, oCampV, create_Regis, producto } from 'src/types/Producto';
import { Usuario } from 'src/types/usuarios';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { productoService } from 'src/app/shared/services/Producto.service';
import { regisOrden } from 'src/types/ordenes';

@Component({
  selector: 'app-registrar-producto',
  templateUrl: './registrar-producto.component.html',
  styleUrls: ['./registrar-producto.component.less']
})
export class RegistrarProductoComponent implements OnInit {
  formReady: boolean = false;
  Form: FormGroup;
  Ordenes: regisOrden[] = [];
  CampoForm: FormGroup;
  valores: oCampV[] = [];
  Regisproductos: Regisproducto[] = [];
  campos: Camp[] = [];
  create_product: create_Regis | undefined;
  Responsables: Usuario[] = []
  productos: producto[] = [];  
  idProducto: string = "";
  idRProducto: string = "";
  idROrden: string = "";
  idCompania: string = "";

  constructor(
    private fb: FormBuilder,
    private location: Location,   
    private route: Router,    
    private ProductoService: productoService,
    private ordenService : ordenService,
    private UsuarioService: UsuarioService
  ) {
    this.Form = this.fb.group({
      id: [''],
      IdUsuario: ['', Validators.required],      
      idProduct: ['', Validators.required], 
      IdRegisOrden: ['', Validators.required],      
      estado: [true],      
      fecha_log: ['']
    });
  
    this.CampoForm = this.fb.group({});
  }

  ngOnInit(): void {
    this.idCompania = this.route.url.split('/')[3];
    this.idRProducto = this.route.url.split('/')[6];

    if (this.idRProducto) {
      // Obtener la información del registro
      this.ProductoService.obtenerR(this.idRProducto).subscribe({
        next: (value) => {
          this.Form.patchValue(value[0]);
          this.idProducto = value[0].idProduct;

          // Obtener la información de los campos
          this.ProductoService.obtener_c_Product(this.idProducto).subscribe({
            next: (Camp) => {
              this.campos = Camp;

              // Obtener los valores de los campos
              this.ProductoService.obtener_RproductoCampVal(this.idRProducto).subscribe({
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

    // Obtener los productos
    this.ProductoService.obtener_Productos(this.idCompania).subscribe({
      next: (value) => {
        this.productos = value;
      },
      error: (error) => {
        console.log(error);
      }
    });
    
    // Obtener registro de Productos
    this.ordenService.obtenerR(this.idCompania).subscribe({
      next: (Value) => {
        this.Ordenes = Value
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })

    // Obtener responsables
    this.UsuarioService.obtener_Operativo(this.idCompania).subscribe({
      next: (value) => {
        this.Responsables = value;
      },
      error: (error) => {
        console.log(error);
      }
    });
  }

   // Post o update a un registro 
   onSubmit(): void {
    if (this.Form.valid) {            
      if(this.idRProducto){  
        // Llamar al servicio para crear la orden
        const formValue = this.Form.value;       
        // Actualizar los valores con los datos del CampoForm
        this.valores.forEach(valor => {
          const campoFormControl = this.CampoForm.get(valor.IdProductCamp); // Busca el FormControl por el id del campo
          if (campoFormControl) {
            valor.valor = campoFormControl.value;  // Actualiza el valor de la lista de valores
          }
        });
        // Crear el objeto de la orden con los campos y sus valores
        this.create_product = {
          producto: formValue,
          campos: this.valores  // Pasar los campos con valores
        };                 
        // hacer la llamada a la api 
        this.ProductoService.updateR(this.idROrden,this.create_product).subscribe({
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
      // Construir el objeto con los campos y sus valores
      const camposConValores: oCampV[] = this.campos.map(campo => {
        const valorCampo = this.CampoForm.get(campo.id)?.value || '';  // Obtener el valor de cada campo desde el formulario
        return {
          id: '',  // Asignar un ID único o dejar en blanco si se genera en el backend
          valor: valorCampo,  // El valor ingresado en el formulario
          IdProductCamp: campo.id,  // El ID del campo
          IdRegisProduct: "",  // Asignar el ID de la orden actual
          fecha_log: ""  // Usar la fecha actual o ajustarla según el caso
        };
      });       
      // Crear el objeto de la orden con los campos y sus valores
      this.create_product = {
        producto: formValue,
        campos: camposConValores  // Pasar los campos con valores
      }; 
      // hacer la llamda al api 
      this.ProductoService.createR(this.create_product).subscribe({
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

   // Obtiene el control del campo
   getControl(campoId: string): FormControl {
    return this.CampoForm.get(campoId) as FormControl;
  }

  // Carga los campos al momento de seleccionar un tipo de producto
  updateCamp(): void {
    const value = this.Form.value.idProduct;
    this.ProductoService.obtener_c_Product(value).subscribe({
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

  // Eliminar un registro delete
  onDelete(): void {
    this.ProductoService.deleteR(this.idRProducto).subscribe({
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

  // Relaciona los valores con los campos 
  getValorPorCampo(campoId: string): oCampV | undefined {    
    return this.valores.find(val => val.IdProductCamp === campoId);
  }

    
}
