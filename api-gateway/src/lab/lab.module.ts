import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { LabController } from './lab.controller';

@Module({
  imports: [HttpModule],
  controllers: [LabController],
})
export class LabModule {}
