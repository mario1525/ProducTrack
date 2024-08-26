import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { OrdenComponent } from './orden/orden.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { ReactiveFormsModule } from '@angular/forms';
import { OrdenesComponent } from './ordenes.component';
import { RegistrarComponent } from './registrar/registrar.component';
import { RegistrosComponent } from './registros/registros.component';



@NgModule({
  declarations: [
    OrdenesComponent,
    OrdenComponent,
    RegistrarComponent,
    RegistrosComponent
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule
  ]
})
export class OrdenesModule { }
