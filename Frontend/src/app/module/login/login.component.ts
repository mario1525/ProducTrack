import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthtenticationService } from 'src/app/shared/services/Auth.service';
import { Router } from '@angular/router';
import { jwtDecode } from 'jwt-decode';
import { TokenserviceService } from 'src/app/shared/services/Token.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.less']
})
export class LoginComponent implements OnInit {
  public myformulario!: FormGroup;
  title = 'Login';
  token: any;

  // Inyecta el servicio AutenticacionService en el constructor
  constructor(private fb: FormBuilder, private Token : TokenserviceService, private auth: AuthtenticationService, private route: Router) { }

  ngOnInit(): void {
    this.myformulario = this.createmyformulario();
  }

  private createmyformulario() {
    return this.fb.group({
      Usuario: [''],
      Contrasenia: ['', [Validators.required, Validators.minLength(5)]],
    });
  }

  private decodeToken(token: string): any {
    try {
      // Decodifica el token JWT
      const decodedToken: any = jwtDecode(token);

      // Puedes acceder a los datos decodificados del token, por ejemplo, el contenido del payload
      console.log('Datos decodificados del token:', decodedToken);

      return decodedToken;
    } catch (error) {
      console.error('Error al decodificar el token:', error);
      return null;
    }
  }

  public submitFormulario() {
    if (this.myformulario.valid) {
      // Mueve la lógica de obtener el token aquí, dentro del if
      this.auth.autenticar(this.myformulario.value).subscribe({
        next: (data) => {
          if (data.error) {
            alert(data.error);
            return;
          }
          if (data.Rol == 'Admin') {
            // Redirige al usuario a la página de inicio
            this.Token.setTokenInCookie(data)
            this.route.navigate(['/App/Home']); // Ajusta la ruta según tu estructura de la aplicación
            return;
          }
          this.Token.setTokenInCookie(data)
          this.route.navigate(['/App/Home']); // Ajusta la ruta según tu estructura de la aplicación
          return;
        },
        error: (error) => { console.log(error); alert('Usuario o contraseña incorrectos') }
      });
      return
    }
    alert('Formulario inválido, por favor revisa los datos ingresados');
    return;
  }
}

