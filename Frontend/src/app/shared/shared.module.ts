import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { NavMenuComponent } from './../component/nav-menu/nav-menu.component';
import { EtapaPopupComponent } from './../component/etapa-popup/etapa-popup.component'
import { ReactiveFormsModule } from '@angular/forms';



@NgModule({
  declarations: [
    NavMenuComponent,
    EtapaPopupComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    ReactiveFormsModule
  ],
  exports: [
    NavMenuComponent,
    EtapaPopupComponent
  ]
})
export class SharedModule { }
