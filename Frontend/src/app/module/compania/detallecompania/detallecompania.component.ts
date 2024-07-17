import { Component, OnInit  } from '@angular/core';
import { Router } from '@angular/router';
import { Compania } from 'src/types/compania';
import { producto } from 'src/types/Producto';
import { lab } from 'src/types/laboratorios';
import { orden } from 'src/types/ordenes';
import { Proceso } from 'src/types/procesos';
import { TokenserviceService } from '../../../shared/services/Token.service';
import { CompaniaService } from 'src/app/shared/services/Compania.service';
import { ordenService } from 'src/app/shared/services/Orden.service';
import { procesoService } from 'src/app/shared/services/Proceso.service';
import { productoService } from 'src/app/shared/services/Producto.service';
import { labService } from 'src/app/shared/services/laboratorio.service';


@Component({
  selector: 'app-detallecompania',
  templateUrl: './detallecompania.component.html',
  styleUrls: ['./detallecompania.component.less']
})
export class DetallecompaniaComponent implements OnInit {
  opciones = false;
  IdCompania: string = "";
  Compania: Compania | undefined;
  procesos: Proceso[] = [];
  laboratorios: lab[] = [];
  ordenes: orden[] = [];
  productos: producto[] = [];
  navRoutes = [
    { path: '/App/Companias', label: 'Compania' },
    { path: '/App/Usuarios', label: 'Usuarios' },
    { path: '/App/Productos', label: 'Productos' },
    { path: '/App/Procesos', label: 'Procesos' },
    { path: '/App/Ordenes', label: 'Ordenes' },
    { path: '/App/Laboratorios', label: 'Laboratorios' }
  ];
  constructor(private route: Router, private procesoService : procesoService, private productoService : productoService, private labService : labService, private CompaniaService : CompaniaService, private ordenService : ordenService , private auth: TokenserviceService) {
  }

  ngOnInit(): void {
    this.IdCompania = this.route.url.split('/')[3]
    this.CompaniaService.obtener_compania(this.IdCompania).subscribe({
      next: (Compania) => {
        this.Compania = Compania
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })

    this.procesoService.obtener_Procesos(this.IdCompania).subscribe({
      next: (Procesos) => {
        this.procesos = Procesos
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })

    this.ordenService.obtener_Orden(this.IdCompania).subscribe({
      next: (ordenes) => {
        this.ordenes = ordenes
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })

    this.productoService.obtener_Productos(this.IdCompania).subscribe({
      next: (productos) => {
        this.productos = productos
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })

    this.labService.obtener_Procesos(this.IdCompania).subscribe({
      next: (laboratorios) => {
        this.laboratorios = laboratorios
        return; 
      },
      error: (error) => {
        console.log(error)
      }
    })
  }

  
  
  

  public homeback() {
    this.route.navigate(['App/Home']);
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
