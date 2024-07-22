import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CompaniaComponent } from './compania.component';
import { DetallecompaniaComponent } from './detallecompania/detallecompania.component';
import { ReactiveFormsModule } from '@angular/forms';

import { SharedModule } from './../../shared/shared.module'
import { share } from 'rxjs';

@NgModule({
  declarations: [
    CompaniaComponent,
    DetallecompaniaComponent
  ],
  imports: [
    CommonModule,
    SharedModule, 
    ReactiveFormsModule
  ]
})
export class CompaniaModule { }
