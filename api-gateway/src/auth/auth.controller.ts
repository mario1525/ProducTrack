import { Controller, Post, Body } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { map } from 'rxjs/operators';

@Controller('auth')
export class AuthController {
  constructor(private readonly httpService: HttpService) {}

  @Post('login')
  login(@Body() body) {
    // Redirigir la solicitud de inicio de sesión al servicio de autenticación
    return this.httpService
      .post('http://auth-service/login', body)
      .pipe(map((response) => response.data));
  }

  @Post('register')
  register(@Body() body) {
    // Redirigir la solicitud de registro al servicio de autenticación
    return this.httpService
      .post('http://auth-service/register', body)
      .pipe(map((response) => response.data));
  }
}
