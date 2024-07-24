import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginComponent } from './module/login/login.component';
import { HomeComponent } from './module/home/home.component';
import { CompaniaComponent } from './module/compania/compania.component';
import { UsuariosComponent } from './module/usuarios/usuarios.component';
import { UsuarioComponent } from './module/usuarios/usuario/usuario.component';
import { ProductosComponent } from './module/productos/productos.component';
import { ProcesosComponent } from './module/procesos/procesos.component';
import { OrdenesComponent } from './module/ordenes/ordenes.component';
import { LaboratoriosComponent } from './module/laboratorios/laboratorios.component';
import { DetallecompaniaComponent } from './module/compania/detallecompania/detallecompania.component';
import { ProcesoComponent } from './module/procesos/proceso/proceso.component';

const routes: Routes = [
    { path: '', redirectTo: 'login', pathMatch: 'full' },
    { path: 'login', component: LoginComponent },
    { path: 'App/Home', component: HomeComponent},

    { path: 'App/Companias', component: CompaniaComponent},
    { path: 'App/Compania', component: DetallecompaniaComponent},
    { path: 'App/Compania/:id', component: DetallecompaniaComponent},

    { path: 'App/Compania/:id/Usuarios', component: UsuariosComponent},
    { path: 'App/Compania/:id/Usuario/:id', component: UsuarioComponent},
    { path: 'App/Compania/:id/Usuario', component: UsuarioComponent},

    { path: 'App/Compania/:id/Procesos', component: ProcesosComponent},
    { path: 'App/Compania/:id/Proceso', component: ProcesoComponent},
    { path: 'App/Compania/:id/Proceso/:id', component: ProcesoComponent},

    { path: 'App/Compania/:id/Productos', component: ProductosComponent},   
    
    { path: 'App/Compania/:id/Ordenes', component: OrdenesComponent},

    { path: 'App/Compania/:id/Laboratorios', component: LaboratoriosComponent}      
  
  ];
  
  @NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
  })
  export class AppRoutingModule { }