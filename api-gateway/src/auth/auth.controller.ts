import { Controller, Post, Body } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { map } from 'rxjs/operators';
import UrlServUsuario from 'src/helpers/serUsuarioUrl';

@Controller('api/auth')
export class AuthController {
  private apiUrl = UrlServUsuario;
  constructor(private readonly httpService: HttpService) {}

  @Post('login')
  login(@Body() body) {
    // Redirigir la solicitud de inicio de sesión al servicio de autenticación
    return this.httpService
      .post(`${this.apiUrl}api/Auth`, body)
      .pipe(map((response) => response.data));
  }
}
