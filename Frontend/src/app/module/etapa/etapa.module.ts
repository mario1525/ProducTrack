import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EtapaOrdenComponent } from './etapa-orden/etapa-orden.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from 'src/app/shared/shared.module';



@NgModule({
  declarations: [
    EtapaOrdenComponent
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule
  ]
})
export class EtapaModule { }
