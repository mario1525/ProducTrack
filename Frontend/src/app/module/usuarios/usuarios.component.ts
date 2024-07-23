import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Usuario } from 'src/types/usuarios';
import {UsuarioService} from 'src/app/shared/services/usuarios.service';
import { TokenserviceService } from '../../shared/services/Token.service';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.less']
})
export class UsuariosComponent implements OnInit {
  Usuarios : Usuario[] = [];
  IdCompania: string = "";
  constructor(private route: Router, private UsuarioService : UsuarioService , private auth: TokenserviceService) {
  }
 ngOnInit(): void {
   this.IdCompania = this.route.url.split('/')[3]   
   this.UsuarioService.obtener_usuariosCompania(this.IdCompania).subscribe({
    next: (usuarios) => {
      this.Usuarios = usuarios
      return; 
    },
    error: (error) => {
      console.log(error)
    }
  })   
 } 

 public redirecCompaniadetalle(indice: number): void {
  // Accede a los datos específicos de la fila actual
  const datosSeleccionados = this.Usuarios[indice];

  // Realiza la redirección con los datos específicos
  this.route.navigate(['App/Usuario', datosSeleccionados.id]);
}

public homeback() {
  this.route.navigate(['App/Compania', this.IdCompania]);
  return
}

public createUsuario() {
  this.route.navigate(['App/Usuario']);
} 

}
