import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { VistaCompania } from 'src/types/compania';
import { TokenserviceService } from '../../shared/services/Token.service';
import { CompaniaService } from 'src/app/shared/services/Compania.service';


@Component({
  selector: 'app-compania',
  templateUrl: './compania.component.html',
  styleUrls: ['./compania.component.less']
})
export class CompaniaComponent implements OnInit {  
  opciones = false
  datos_Companias: VistaCompania[] = [];
  constructor(private route: Router, private CompaniaService : CompaniaService , private auth: TokenserviceService) {
  }

  ngOnInit(): void {
    this.CompaniaService.obtener_companias().subscribe({
      next: (Companias) => {
        this.datos_Companias = Companias
        return;
      },
      error: (error) => {
        console.log(error)
      }
    })
  }

  public homeback() {
    this.route.navigate(['app/home']);
    return
  }

  public cerrarsession() {
    //localStorage.removeItem('token')
    this.auth
      .removeTokenFromCookie()
      .then(() => {
        this.route.navigate(['login']);
      })
      .catch((error) => {
        console.log(error);
        alert('Error al eliminar la cookie');
      });

    return;
  }
}
