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
    
    ZZResultLabelZ20 as CalibrationResult // "as CalibrationResult" is optional.Because,it is already defined 
                                          //  as enduser text label such as "@EndUserText.label: ' Calibration Result! '" 
                                          //  in "zx_cal_v_ma".
}
