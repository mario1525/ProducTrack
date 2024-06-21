import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { NavMenuComponent } from './../component/nav-menu/nav-menu.component';



@NgModule({
  declarations: [
    NavMenuComponent
  ],
  imports: [
    CommonModule,
    RouterModule
  ],
  exports: [
    NavMenuComponent
  ]
})
export class SharedModule { }
