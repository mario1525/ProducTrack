import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { HttpModule } from '@nestjs/axios';
import { UsuarioModule } from './usuario/usuario.module';
import { CompaniaModule } from './compania/compania.module';

@Module({
  imports: [AuthModule, HttpModule, UsuarioModule, CompaniaModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
