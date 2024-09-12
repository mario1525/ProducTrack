import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProductosComponent } from '../productos/productos.component';

import { SharedModule } from './../../shared/shared.module';
import { ProductoComponent } from './producto/producto.component'
import { ReactiveFormsModule } from '@angular/forms';
import { RegistrarProductoComponent } from './registrar-producto/registrar-producto.component';
import { RegistrosProductoComponent } from './registros-producto/registros-producto.component';

@NgModule({
  declarations: [
    ProductosComponent,
    ProductoComponent,
    RegistrarProductoComponent,
    RegistrosProductoComponent
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule
  ]
})
export class ProductosModule { }
