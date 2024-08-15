import { Module } from '@nestjs/common';
import { ProductoController } from './producto.controller';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [HttpModule],
  controllers: [ProductoController],
})
export class ProductoModule {}
