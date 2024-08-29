import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { NavMenuComponent } from './../component/nav-menu/nav-menu.component';
import { EtapaPopupComponent } from './../component/etapa-popup/etapa-popup.component'
import { InputComponent } from './../component/input/input.component'
import { ReactiveFormsModule } from '@angular/forms';



@NgModule({
  declarations: [
    NavMenuComponent,
    InputComponent,
    EtapaPopupComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    ReactiveFormsModule
  ],
  exports: [
    NavMenuComponent,
    InputComponent,
    EtapaPopupComponent
  ]
})
export class SharedModule { }
