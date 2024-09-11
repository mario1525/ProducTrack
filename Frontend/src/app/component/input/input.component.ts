import { Component, Input } from '@angular/core';
import { FormControl } from '@angular/forms';
import { oCamp} from 'src/types/ordenes';

@Component({
  selector: 'app-input',
  templateUrl: './input.component.html',
  styleUrls: ['./input.component.less']
})
export class InputComponent {

  @Input() camp: oCamp | undefined; 
  @Input() control: FormControl = new FormControl(); 

  getInputType(tipoDato: string | undefined): string {
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
