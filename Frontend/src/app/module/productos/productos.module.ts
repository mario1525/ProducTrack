import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProductosComponent } from '../productos/productos.component';

import { SharedModule } from './../../shared/shared.module';
import { ProductoComponent } from './producto/producto.component'
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    ProductosComponent,
    ProductoComponent
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule
  ]
})
export class ProductosModule { }
