import { Component } from '@angular/core';
import { TokenserviceService } from './../../shared/services/Token.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.less']
})
export class HomeComponent {
  opciones = true
  navRoutes = [
    { path: '/App/Companias', label: 'Compania' },
    { path: '/App/Usuarios', label: 'Usuarios' },
    { path: '/App/Productos', label: 'Productos' },
    { path: '/App/Procesos', label: 'Procesos' },
    { path: '/App/Ordenes', label: 'Ordenes' },
    { path: '/App/Laboratorios', label: 'Laboratorios' }
  ];
  constructor(private route: Router,  private auth: TokenserviceService) {

  }
   public opcionesclick() {
    this.opciones = !this.opciones
  }

  public cerrarsession() {

    this.auth
      .removeTokenFromCookie()
      .then(() => {
        alert("session cerrada")
        this.route.navigate(['login']);
      })
      .catch((error) => {
        console.log(error);
        alert('Error al eliminar la cookie');
      });

    return;
  }
}
