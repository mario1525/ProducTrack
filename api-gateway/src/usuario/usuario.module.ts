import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { UsuarioController } from './usuario.controller';

@Module({
  imports: [HttpModule],
  controllers: [UsuarioController],
})
export class UsuarioModule {}
