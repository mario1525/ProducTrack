import { Module } from '@nestjs/common';
import { CompaniaController } from './compania.controller';

@Module({
  controllers: [CompaniaController]
})
export class CompaniaModule {}
