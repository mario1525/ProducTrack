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
import UrlServUsuario from 'src/helpers/serUsuarioUrl';

@Controller('api/usuario')
export class UsuarioController {
  private apiUrl = UrlServUsuario;
  constructor(private readonly httpService: HttpService) {}

  @Post()
  create(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Usuario`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Get()
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

  @Get('supervisor/:id')
  GetsSv(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Usuario/Compania/Supervisor/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('operativo/:id')
  GetsOp(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Usuario/Compania/Operativo/${id}`, { headers })
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

  // credenciales

  @Get('credential/:id')
  GetCredential(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Credential/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('credential')
  Credential(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Credential`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Put('credential:id')
  updatec(
    @Param('id') id: string,
    @Body() body,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .put(`${this.apiUrl}api/Credential/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('credential:id')
  removec(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Credential/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  // proyecto usuarioH

  @Get('proyecto/:id')
  GetProyectos(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Usuario/Proyecto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('proyecto')
  Proyecto(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Usuario/Proyecto`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Put('proyecto:id')
  updateP(
    @Param('id') id: string,
    @Body() body,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .put(`${this.apiUrl}api/Usuario/Proyecto/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('proyecto:id')
  removep(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Usuario/Proyecto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }
}
