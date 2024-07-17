import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DetallecompaniaComponent } from './detallecompania.component';

describe('DetallecompaniaComponent', () => {
  let component: DetallecompaniaComponent;
  let fixture: ComponentFixture<DetallecompaniaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DetallecompaniaComponent]
    });
    fixture = TestBed.createComponent(DetallecompaniaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
