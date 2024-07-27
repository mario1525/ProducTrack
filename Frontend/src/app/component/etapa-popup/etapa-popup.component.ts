import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { procesoService } from 'src/app/shared/services/Proceso.service';
import { Location } from '@angular/common';

@Component({
  selector: 'app-etapa-popup',
  templateUrl: './etapa-popup.component.html',
  styleUrls: ['./etapa-popup.component.less']
})
export class EtapaPopupComponent implements OnInit {
  @Input() IdEtapa: string = "";
  @Input() idProceso: string = "";
  etapaForm: FormGroup;
  mostrar = true;

  constructor(private fb: FormBuilder,private location: Location, private procesoService: procesoService) {
    this.etapaForm = this.fb.group({
      id: [''],
      nombre: ['', Validators.required],
      nEtapa: ['', Validators.required],           
      idProceso: [''],      
      estado: [true],            
      fecha_log: ['']
    });
  }

  ngOnInit(): void {
    if(this.IdEtapa){
      this.mostrar = true
      this.procesoService.obtener_etapa(this.IdEtapa).subscribe({
        next: (Etapa) => {
          this.etapaForm.patchValue(Etapa[0])                   
          return; 
        },
        error: (error) => {
          console.log(error)
        }
      })    
    }

  }
  

  onSubmit(): void {
    if (this.etapaForm.valid) {
      let Value = this.etapaForm.value
      //console.log(Value)
      if(this.IdEtapa){
        this.procesoService.update_etapa(this.IdEtapa,Value).subscribe({
          next: () => {
            alert("etapa actualizada")
            
            //this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al actualizar la etapa');
          }
        })
      } else {
        Value.idProceso = this.idProceso
        console.log(Value)
        this.procesoService.create_etapa(Value).subscribe({
          next: () => {
            alert("etapa creada")
            
            //this.location.back();
          },
          error: (error) =>{
            console.log(error)
            alert('Error al crear la etapa');
          }
        })
      }      
    }
  }
}
