import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EtapaPopupComponent } from './etapa-popup.component';

describe('EtapaPopupComponent', () => {
  let component: EtapaPopupComponent;
  let fixture: ComponentFixture<EtapaPopupComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [EtapaPopupComponent]
    });
    fixture = TestBed.createComponent(EtapaPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
