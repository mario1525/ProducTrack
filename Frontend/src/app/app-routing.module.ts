import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginComponent } from './module/login/login.component';
import { HomeComponent } from './module/home/home.component';
import { CompaniaComponent } from './module/compania/compania.component';
import { UsuariosComponent } from './module/usuarios/usuarios.component';
import { ProductosComponent } from './module/productos/productos.component';

const routes: Routes = [
    { path: '', redirectTo: 'login', pathMatch: 'full' },
    { path: 'login', component: LoginComponent },
    { path: 'App/Home', component: HomeComponent},
    { path: 'App/Compania', component: CompaniaComponent},
    { path: 'App/Usuarios', component: UsuariosComponent},
    { path: 'App/Productos', component: ProductosComponent}      
  
  ];
  
  @NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
  })
  export class AppRoutingModule { }