import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UsuariosComponent } from './usuarios.component';
import { UsuarioComponent } from './usuario/usuario.component';
import { ReactiveFormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    UsuariosComponent,
    UsuarioComponent
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule
  ]
})
export class UsuariosModule { }
