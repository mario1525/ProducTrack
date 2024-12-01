import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { HttpModule } from '@nestjs/axios';
import { UsuarioModule } from './usuario/usuario.module';
import { CompaniaModule } from './compania/compania.module';
import { ProcesoModule } from './proceso/proceso.module';
import { ProductoModule } from './producto/producto.module';
import { OrdenModule } from './orden/orden.module';
import { EtapaController } from './etapa/etapa.controller';
import { EtapaModule } from './etapa/etapa.module';
import { ProyectoModule } from './proyecto/proyecto.module';

@Module({
  imports: [
    AuthModule,
    HttpModule,
    UsuarioModule,
    CompaniaModule,
    ProcesoModule,
    ProductoModule,
    OrdenModule,
    EtapaModule,
    ProyectoModule,
  ],
  controllers: [AppController, EtapaController],
  providers: [AppService],
})
export class AppModule {}
