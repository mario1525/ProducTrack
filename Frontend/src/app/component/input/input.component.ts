import { Component, Input } from '@angular/core';
import { oCamp } from 'src/types/ordenes';

@Component({
  selector: 'app-input',
  templateUrl: './input.component.html',
  styleUrls: ['./input.component.less']
})
export class InputComponent {

  @Input() values: oCamp[] = [];  

  getInputType(tipoDato: string): string {
    switch (tipoDato) {
      case 'int':
        return 'number';
      case 'string':
        return 'text';
      default:
        return 'text';
    }
  }
  

}
