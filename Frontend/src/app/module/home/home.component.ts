import { Component } from '@angular/core';
import { TokenserviceService } from './../../shared/services/Token.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.less']
})
export class HomeComponent {
  
  
  constructor(private route: Router,  private auth: TokenserviceService) {

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
