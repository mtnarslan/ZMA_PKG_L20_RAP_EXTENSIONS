@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Calibration Data Definition'
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility:{
    extensible: true,
    elementSuffix: 'Z20',
    allowNewDatasources: false,
    dataSources: ['Calibration'],
    quota: { maximumFields: 10, maximumBytes: 1000 }
}

define root view entity ZR_CAL_MA
  as select from zcal_ma as Calibration
{
  key Calibration.uuid                  as Uuid,
      Calibration.instrument_code       as InstrumentCode,
      Calibration.result_code           as ResultCode,
      Calibration.calibration_note      as CalibrationNote,
      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Calibration.local_last_changed_at as LocalLastChangedAt
}
