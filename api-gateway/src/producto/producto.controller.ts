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

@Controller('api/producto')
export class ProductoController {
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
      .get(`${this.apiUrl}api/Producto/Compania/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get(':id')
  Get(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Producto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post()
  create(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Producto`, body, { headers })
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
      .put(`${this.apiUrl}api/Producto/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete(':id')
  remove(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Producto/${id}`, { headers })
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
      .get(`${this.apiUrl}api/Producto/Campo/Producto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('campo/:id')
  GetC(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrl}api/Producto/campo/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('campo')
  createC(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Producto/campo`, body, { headers })
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
      .put(`${this.apiUrl}api/Producto/campo/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('campo/:id')
  removeC(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrl}api/Producto/campo/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  // Registro Producto

  @Get('registro/compania/:id')
  GetsR(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Producto/Compania/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('registro/Orden/:id')
  GetsROrden(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Producto/Orden/${id}`, { headers })
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
      .get(`${this.apiUrlNeg}api/Producto/Usuario/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('registro/:id')
  GetR(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Producto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('registro')
  createR(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrlNeg}api/Producto`, body, { headers })
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
      .put(`${this.apiUrlNeg}api/Producto/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('registro/:id')
  removeR(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrlNeg}api/Producto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  // Registro product Camp val

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
      .get(`${this.apiUrlNeg}api/Producto/Val/Producto/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Get('registro/val/:id')
  GetRC(@Param('id') id: string, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .get(`${this.apiUrlNeg}api/Producto/Val/${id}`, { headers })
      .pipe(map((response) => response.data));
  }

  @Post('registro/val')
  createRC(@Body() body, @Headers('authorization') authHeader: string) {
    const headers = {
      Authorization: authHeader, // Reenvía el token de autenticación
    };
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrlNeg}api/Producto/Val`, body, { headers })
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
      .put(`${this.apiUrlNeg}api/Producto/Val/${id}`, body, { headers })
      .pipe(map((response) => response.data));
  }

  @Delete('registro/val/:id')
  removeRC(
    @Param('id') id: string,
    @Headers('authorization') authHeader: string,
  ) {
    const headers = { Authorization: authHeader };
    return this.httpService
      .delete(`${this.apiUrlNeg}api/Producto/Val/${id}`, { headers })
      .pipe(map((response) => response.data));
  }
}
