import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Usuario } from 'src/types/usuarios';
import {UsuarioService} from 'src/app/shared/services/usuarios.service'
import { TokenserviceService } from '../../../shared/services/Token.service';
import { Location } from '@angular/common';


@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styleUrls: ['./usuario.component.less']
})
export class UsuarioComponent implements OnInit {
  userForm: FormGroup;
  Usuario: Usuario | undefined;
  idUsuario: string = "";
  idCompania: string = "";


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
      idCompania: [ ''],
      correo: ['', [Validators.required, Validators.email]],
      rol: ['', Validators.required],
      cargo: ['', Validators.required],
      estado: [''],      
      fecha_log: ['']
    });    
  }  

  ngOnInit(): void {  
    this.idCompania = this.route.url.split('/')[3] 
    this.idUsuario = this.route.url.split('/')[5]    
    if(this.idUsuario){
      this.UsuaioService.obtener_usuario(this.idUsuario).subscribe({
        next: (Usuario) => {
          this.userForm.patchValue(Usuario[0])                           
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
      let usuario = this.userForm.value      
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
        usuario.idCompania = this.idCompania;                  
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
