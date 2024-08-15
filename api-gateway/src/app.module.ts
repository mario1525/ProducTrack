import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { HttpModule } from '@nestjs/axios';
import { UsuarioModule } from './usuario/usuario.module';
import { CompaniaModule } from './compania/compania.module';
import { ProcesoModule } from './proceso/proceso.module';
import { LabModule } from './lab/lab.module';
import { ProductoModule } from './producto/producto.module';
import { OrdenModule } from './orden/orden.module';

@Module({
  imports: [
    AuthModule,
    HttpModule,
    UsuarioModule,
    CompaniaModule,
    ProcesoModule,
    LabModule,
    ProductoModule,
    OrdenModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
