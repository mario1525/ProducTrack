import {
  Controller,
  Post,
  Get,
  Put,
  Delete,
  Param,
  Body,
  Headers,
  UnauthorizedException,
} from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { map } from 'rxjs/operators';
import UrlServAdmin from 'src/helpers/indexUrl';

@Controller('api/proyecto')
export class ProyectoController {
  private apiUrl = UrlServAdmin;
  constructor(private readonly httpService: HttpService) {}

  @Get('compania/:id')
  Gets(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    if (!authHeader) {
      throw new UnauthorizedException('Authorization header missing');
    }

    const headers = {
      Authorization: authHeader,
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Proyecto/Compania/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get(':id')
  Get(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Proyecto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post()
  create(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Proyecto`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Put(':id')
  update(
    @Param('id') id: string,
    @Body() body,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .put(`${this.apiUrl}api/Proyecto/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete(':id')
  remove(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Proyecto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }
}
