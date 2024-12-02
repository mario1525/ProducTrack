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
import { DetallecompaniaComponent } from './module/compania/detallecompania/detallecompania.component';
import { ProcesoComponent } from './module/procesos/proceso/proceso.component';
import { CredentialComponent } from './module/usuarios/credential/credential.component';
import { OrdenComponent } from './module/ordenes/orden/orden.component';
import { ProductoComponent } from './module/productos/producto/producto.component';
import { RegistrosComponent } from './module/ordenes/registros/registros.component'
import { RegistrarComponent } from './module/ordenes/registrar/registrar.component'
import { RegistrarProductoComponent } from './module/productos/registrar-producto/registrar-producto.component';
import { RegistrosProductoComponent } from './module/productos/registros-producto/registros-producto.component';
import { EtapaOrdenComponent } from './module/etapa/etapa-orden/etapa-orden.component';
import { ProyectosComponent } from './module/proyectos/proyectos.component';
import { ProyectoComponent } from './module/proyectos/proyecto/proyecto.component';
import { TipoComponent } from './module/ordenes/tipo/tipo.component';

const routes: Routes = [
    { path: '', redirectTo: 'login', pathMatch: 'full' },
    { path: 'login', component: LoginComponent },
    { path: 'App/Home', component: HomeComponent},

    { path: 'App/Companias', component: CompaniaComponent},
    { path: 'App/Compania', component: DetallecompaniaComponent},
    { path: 'App/Compania/:id', component: DetallecompaniaComponent},

    { path: 'App/Compania/:id/Proyectos', component: ProyectosComponent},
    { path: 'App/Compania/:id/Proyecto', component: ProyectoComponent},
    { path: 'App/Compania/:id/Proyecto/:id', component: ProyectoComponent},

    { path: 'App/Compania/:id/Proyecto/:id/TipoOrden/:id', component: TipoComponent},
    { path: 'App/Compania/:id/Proyecto/:id/TipoOrden', component: TipoComponent},

    { path: 'App/Compania/:id/Usuarios', component: UsuariosComponent},
    { path: 'App/Compania/:id/Usuario/:id', component: UsuarioComponent},
    { path: 'App/Compania/:id/Usuario/:id/Credential', component: CredentialComponent},
    { path: 'App/Compania/:id/Usuario/:id/Credential/:id', component: CredentialComponent},
    { path: 'App/Compania/:id/Usuario', component: UsuarioComponent},

    { path: 'App/Compania/:id/Procesos', component: ProcesosComponent},
    { path: 'App/Compania/:id/Proceso', component: ProcesoComponent},
    { path: 'App/Compania/:id/Proceso/:id', component: ProcesoComponent},

    { path: 'App/Compania/:id/Productos', component: ProductosComponent},   
    { path: 'App/Compania/:id/Producto', component: ProductoComponent},
    { path: 'App/Compania/:id/Producto/:id', component: ProductoComponent}, 
    { path: 'App/Compania/:id/Registros/Productos', component: RegistrosProductoComponent},   
    { path: 'App/Compania/:id/Registro/Producto', component: RegistrarProductoComponent},
    { path: 'App/Compania/:id/Registro/Producto/:id', component: RegistrarProductoComponent},

    { path: 'App/Compania/:id/Ordenes', component: OrdenesComponent},
    { path: 'App/Compania/:id/Orden/:id', component: OrdenComponent},
    { path: 'App/Compania/:id/Orden', component: OrdenComponent},
    { path: 'App/Compania/:id/Registro/Orden/:id', component: RegistrarComponent},
    { path: 'App/Compania/:id/Registro/Orden', component: RegistrarComponent},
    { path: 'App/Compania/:id/Registros/Ordenes', component: RegistrosComponent},
    { path: 'App/Compania/:id/Registro/Orden/:id/Etapa/:id', component: EtapaOrdenComponent},
    { path: 'App/Compania/:id/Registro/Orden/:id/Etapa', component: EtapaOrdenComponent},
    
 
          
  ];
  
  @NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
  })
  export class AppRoutingModule { }