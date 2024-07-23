import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Usuario } from 'src/types/usuarios';
import {UsuarioService} from 'src/app/shared/services/usuarios.service'
import { TokenserviceService } from '../../../shared/services/Token.service';
import { Location } from '@angular/common';
import { Compania } from 'src/types/compania';


@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styleUrls: ['./usuario.component.less']
})
export class UsuarioComponent implements OnInit {
  userForm: FormGroup;
  Usuario: Usuario | undefined;
  idUsuario: string = "";


  constructor(
    private fb: FormBuilder,
    private location: Location,
    private auth: TokenserviceService, 
    private route: Router,
    private UsuaioService: UsuarioService
  ) {
    this.userForm = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],
      apellido: ['', Validators.required],
      identificacion: ['', Validators.required],
      idCompania: ['', Validators.required],
      correo: ['', [Validators.required, Validators.email]],
      rol: ['', Validators.required],
      cargo: ['', Validators.required],
      estado: [''],      
      fecha_log: ['']
    });
  }

  ngOnInit(): void {
    this.idUsuario = this.route.url.split('/')[3] 
    if(this.idUsuario){
      this.UsuaioService.obtener_usuario(this.idUsuario).subscribe({
        next: (Usuario) => {
          this.userForm.patchValue(Usuario[0])
          this.Usuario         
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })

    }
  }

  onSubmit(): void {
    if (this.userForm.valid) {
      const usuario = this.userForm.value
      console.log(usuario)
      if(this.idUsuario){
        this.UsuaioService.update_usuario(this.idUsuario,usuario).subscribe({
          next: () => {
            alert("usuario Actualizado actualizada")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar el usuario');
          }
        })
      } else {
        this.UsuaioService.create_usuario(usuario).subscribe({
          next: () => {
            alert("usuario creado")
            this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear el usuario');
          }
        })
      }        
    } else {
      alert("formulario invalido")
    }
  }

  onDelete(): void {
    this.UsuaioService.delete_usuario(this.idUsuario).subscribe({
      next: () => {
        alert("usuario eliminado")
        this.location.back();
      },
      error: (error) =>{
        console.log(error)
        alert('Error al eliminar el usuario');
      }
    })
  } 

}
