import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EtapaOrdenComponent } from './etapa-orden.component';

describe('EtapaOrdenComponent', () => {
  let component: EtapaOrdenComponent;
  let fixture: ComponentFixture<EtapaOrdenComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [EtapaOrdenComponent]
    });
    fixture = TestBed.createComponent(EtapaOrdenComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
