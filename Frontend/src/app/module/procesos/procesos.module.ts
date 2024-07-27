import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProcesosComponent } from './procesos.component';
import { ProcesoComponent } from './proceso/proceso.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from 'src/app/shared/shared.module';



@NgModule({
  declarations: [
    ProcesosComponent,
    ProcesoComponent
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule
  ]
})
export class ProcesosModule { }
