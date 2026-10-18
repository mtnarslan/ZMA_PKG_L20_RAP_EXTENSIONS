@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Calibration Data Definition projection'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_CAL_MA 
provider contract transactional_query
  as projection on ZR_CAL_MA
{
    key Uuid,
    
    @Search.defaultSearchElement: true
    InstrumentCode,
    
    @Search.defaultSearchElement: true
    ResultCode,
    
    ResponsibleUser,
    
    CalibrationNote,
    LocalLastChangedAt,
    LastChangedAt,
    
    ZZResultLabelZ20 as CalibrationResult
}
