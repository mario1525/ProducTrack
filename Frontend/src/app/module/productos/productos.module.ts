import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProductosComponent } from '../productos/productos.component';

import { SharedModule } from './../../shared/shared.module'

@NgModule({
  declarations: [
    ProductosComponent
  ],
  imports: [
    CommonModule,
    SharedModule
  ]
})
export class ProductosModule { }
