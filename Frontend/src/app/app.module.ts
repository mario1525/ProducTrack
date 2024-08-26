import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { LoginModule } from './module/login/login.module';
import { HomeModule } from './module/home/home.module';
import { CompaniaModule } from './module/compania/compania.module';
import { UsuariosModule } from './module/usuarios/usuarios.module';
import { SharedModule } from './shared/shared.module';
import { HeaderComponent } from './component/header/header.component';
import { ProductosModule } from './module/productos/productos.module';
import { LaboratoriosModule } from './module/laboratorios/laboratorios.module';
import { ProcesosModule } from './module/procesos/procesos.module';
import { OrdenesModule } from './module/ordenes/ordenes.module';

@NgModule({
  declarations: [
    AppComponent,    
    HeaderComponent
  ],
  imports: [
    HttpClientModule,
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    LoginModule,
    SharedModule,
    HomeModule,
    LaboratoriosModule,
    ProcesosModule,
    OrdenesModule,
    CompaniaModule,
    UsuariosModule,
    ProductosModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
