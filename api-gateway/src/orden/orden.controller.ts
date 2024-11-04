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
import UrlServNegocio from 'src/helpers/servNegocioUrl';

@Controller('api/orden')
export class OrdenController {
  private apiUrl = UrlServAdmin;
  private apiUrlNeg = UrlServNegocio;
  constructor(private readonly httpService: HttpService) {}

  @Get('compania/:id')
  Gets(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Orden/Compania/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get(':id')
  Get(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Orden/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post()
  create(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Orden`, body, { headers })
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
      .put(`${this.apiUrl}api/Orden/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete(':id')
  remove(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Orden/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  // Campos

  @Get('campos/:id')
  GetsC(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Orden/Campo/Orden/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('campo/:id')
  GetC(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Orden/Campo/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('campo')
  createC(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Orden/campo`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Put('campo/:id')
  updateC(
    @Param('id') id: string,
    @Body() body,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .put(`${this.apiUrl}api/Orden/campo/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('campo/:id')
  removeC(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Orden/campo/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  // Registro Orden
  @Get('registro/compania/:id')
  GetsR(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Orden/Compania/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('registro/usuario/:id')
  GetsRU(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Orden/Usuario/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('registro/:id')
  GetR(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Orden/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('registro')
  createR(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrlNeg}api/Orden`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Put('registro/:id')
  updateR(
    @Param('id') id: string,
    @Body() body,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .put(`${this.apiUrlNeg}api/Orden/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('registro/:id')
  removeR(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrlNeg}api/Orden/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  // Registro Orden Camp

  @Get('registro/values/:id')
  GetsRC(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Orden/Val/Orden/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('registro/val/:id')
  GetRC(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Orden/Val/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('registro/val')
  createRC(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrlNeg}api/Orden/Val`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Put('registro/val/:id')
  updateRC(
    @Param('id') id: string,
    @Body() body,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .put(`${this.apiUrlNeg}api/Orden/Val/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('registro/val/:id')
  removeRC(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrlNeg}api/Orden/Val/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  // etapa
  @Get('etapa/:id')
  GetEtap(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Orden/Etapa/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('etapa')
  createEtap(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrlNeg}api/Orden/Etapa`, body, { headers })
      .pipe(map((response) => response.data));
  }
}
