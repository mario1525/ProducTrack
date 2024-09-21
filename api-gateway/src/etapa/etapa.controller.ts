import {
  Controller,
  Post,
  Get,
  Put,
  Delete,
  Param,
  Body,
  Headers,
} from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { map } from 'rxjs/operators';
import UrlServAdmin from 'src/helpers/indexUrl';

@Controller('api/etapa')
export class EtapaController {
  private apiUrl = UrlServAdmin;
  constructor(private readonly httpService: HttpService) {}

  @Get('proceso/:id')
  GetsE(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Etapa/Proceso/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get(':id')
  GetE(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Etapa/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post()
  createE(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Etapa`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Put(':id')
  updateE(
    @Param('id') id: string,
    @Body() body,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .put(`${this.apiUrl}api/Etapa/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete(':id')
  removeE(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Etapa/${id}`, { headers })
      .pipe(map((response) => response.data));
  }
}
