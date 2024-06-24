import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.less']
})
export class HomeComponent {
  navRoutes = [
    { path: '/App/Compania', label: 'Compania' },
    { path: '/App/Usuarios', label: 'Usuarios' },
    { path: '/App/Productos', label: 'Productos' },
    { path: '/App/Procesos', label: 'Procesos' },
    { path: '/App/Ordenes', label: 'Ordenes' },
    { path: '/App/Laboratorios', label: 'Laboratorios' }
  ];
}
