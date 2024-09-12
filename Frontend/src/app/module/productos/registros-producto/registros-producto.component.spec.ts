import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RegistrosProductoComponent } from './registros-producto.component';

describe('RegistrosProductoComponent', () => {
  let component: RegistrosProductoComponent;
  let fixture: ComponentFixture<RegistrosProductoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [RegistrosProductoComponent]
    });
    fixture = TestBed.createComponent(RegistrosProductoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
