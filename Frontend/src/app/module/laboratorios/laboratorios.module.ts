import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LaboratoriosComponent } from './laboratorios.component';
import { LaboratorioComponent } from './laboratorio/laboratorio.component';
import { ReactiveFormsModule } from '@angular/forms';



@NgModule({
  declarations: [
    LaboratoriosComponent,
    LaboratorioComponent
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule
  ]
})
export class LaboratoriosModule { }
