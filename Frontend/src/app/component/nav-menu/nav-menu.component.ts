import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.less']
})
export class NavMenuComponent {
  @Input() IdCompania: string = "";
  @Input() routes: { path: string, label: string }[] = [];
  constructor(private router: Router) {}

  getProcessedPath(path: string): string {
    return path.replace(':id', this.IdCompania);
  }

  navigateTo(path: string): void {
    this.router.navigate([path]);
  }
}
