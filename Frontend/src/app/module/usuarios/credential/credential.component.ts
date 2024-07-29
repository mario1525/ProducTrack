import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Usuario, Credential } from 'src/types/usuarios';
import {UsuarioService} from 'src/app/shared/services/usuarios.service'
import { TokenserviceService } from '../../../shared/services/Token.service';
import { Location } from '@angular/common';

@Component({
  selector: 'app-credential',
  templateUrl: './credential.component.html',
  styleUrls: ['./credential.component.less']
})
export class CredentialComponent implements OnInit {
  form: FormGroup;
  idUsuario: string = "";

  constructor(private fb: FormBuilder,
    private location: Location,     
    private route: Router,
    private UsuaioService: UsuarioService
  ) {
    this.form = this.fb.group({
      id: [''],
      usuario: ['', Validators.required],
      contrasenia: ['', [Validators.required, Validators.minLength(10)]],
      idUsuario: [''],
      confirmarContrasena: ['', Validators.required],
      estado: [''],      
      fecha_log: ['']
    });
  }

  ngOnInit(): void {  
    this.idUsuario = this.route.url.split('/')[5]   
  }

  onSubmit(): void {
    if (this.form.valid) {
      if (this.form.value.contrasenia == this.form.value.confirmarContrasena ){
        let credential = this.form.value
      credential.idUsuario = this.idUsuario;
      console.log(credential)                  
        this.UsuaioService.create_Credential(credential).subscribe({          
          next: () => {
            alert("Credenciales asignadas correctamente")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al asignar las credenciales');
          }
        }) 
      } else {
        alert('la contraseña no coinciden');
      } 
  }else {
    alert('formulario invalido');     
}
}
}

