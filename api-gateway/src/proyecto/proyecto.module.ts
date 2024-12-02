import { Module } from '@nestjs/common';
import { ProyectoController } from './proyecto.controller';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [HttpModule],
  controllers: [ProyectoController],
})
export class ProyectoModule {}
