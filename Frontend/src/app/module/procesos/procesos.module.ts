import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProcesosComponent } from './procesos.component';
import { ProcesoComponent } from './proceso/proceso.component';
import { ReactiveFormsModule } from '@angular/forms';



@NgModule({
  declarations: [
    ProcesosComponent,
    ProcesoComponent
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule
  ]
})
export class ProcesosModule { }
