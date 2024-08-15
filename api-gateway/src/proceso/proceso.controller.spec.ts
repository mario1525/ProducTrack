import { Test, TestingModule } from '@nestjs/testing';
import { ProcesoController } from './proceso.controller';

describe('ProcesoController', () => {
  let controller: ProcesoController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ProcesoController],
    }).compile();

    controller = module.get<ProcesoController>(ProcesoController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
