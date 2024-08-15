import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { OrdenController } from './orden.controller';

@Module({
  imports: [HttpModule],
  controllers: [OrdenController],
})
export class OrdenModule {}
