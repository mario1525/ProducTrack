import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { CompaniaController } from './compania.controller';

@Module({
  imports: [HttpModule],
  controllers: [CompaniaController],
})
export class CompaniaModule {}
