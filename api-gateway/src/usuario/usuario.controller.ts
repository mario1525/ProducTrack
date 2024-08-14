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

@Controller('usuario')
export class UsuarioController {
  private apiUrl = UrlServAdmin;
  constructor(private readonly httpService: HttpService) {}

  @Post('')
  create(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Usuario`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('users')
  Gets(@Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Usuario`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('compania/:id')
  GetsC(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Usuario/Compania/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get(':id')
  Get(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Usuario/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('')
  Credential(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Credential`, body, { headers })
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
      .put(`${this.apiUrl}api/Usuario/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete(':id')
  remove(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Usuario/${id}`, { headers })
      .pipe(map((response) => response.data));
  }
}
