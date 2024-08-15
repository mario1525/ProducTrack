import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { ProcesoController } from './proceso.controller';

@Module({
  imports: [HttpModule],
  controllers: [ProcesoController],
})
export class ProcesoModule {}
