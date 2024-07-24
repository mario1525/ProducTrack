import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProductosComponent } from '../productos/productos.component';

import { SharedModule } from './../../shared/shared.module';
import { ProductoComponent } from './producto/producto.component'

@NgModule({
  declarations: [
    ProductosComponent,
    ProductoComponent
  ],
  imports: [
    CommonModule,
    SharedModule
  ]
})
export class ProductosModule { }
