import { Component } from '@angular/core';
import { TokenserviceService } from './../../shared/services/Token.service';
import { Router, NavigationEnd } from '@angular/router';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.less']
})
export class HeaderComponent {
  opciones = false 
  showHeader: boolean = true; 
  constructor(private route: Router,  private auth: TokenserviceService) {
    this.route.events.subscribe((event) => {
      if (event instanceof NavigationEnd) {
        this.showHeader = event.url !== '/login';
      }
    });
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
