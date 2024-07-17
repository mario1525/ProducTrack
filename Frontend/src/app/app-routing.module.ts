import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginComponent } from './module/login/login.component';
import { HomeComponent } from './module/home/home.component';
import { CompaniaComponent } from './module/compania/compania.component';
import { UsuariosComponent } from './module/usuarios/usuarios.component';
import { ProductosComponent } from './module/productos/productos.component';
import { ProcesosComponent } from './module/procesos/procesos.component';
import { OrdenesComponent } from './module/ordenes/ordenes.component';
import { LaboratoriosComponent } from './module/laboratorios/laboratorios.component';
import { DetallecompaniaComponent } from './module/compania/detallecompania/detallecompania.component';

const routes: Routes = [
    { path: '', redirectTo: 'login', pathMatch: 'full' },
    { path: 'login', component: LoginComponent },
    { path: 'App/Home', component: HomeComponent},
    { path: 'App/Companias', component: CompaniaComponent},
    { path: 'App/Compania/:id', component: DetallecompaniaComponent},
    { path: 'App/Usuarios', component: UsuariosComponent},
    { path: 'App/Productos', component: ProductosComponent},
    { path: 'App/Procesos', component: ProcesosComponent},
    { path: 'App/Ordenes', component: OrdenesComponent},
    { path: 'App/Laboratorios', component: LaboratoriosComponent}      
  
  ];
  
  @NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
  })
  export class AppRoutingModule { }