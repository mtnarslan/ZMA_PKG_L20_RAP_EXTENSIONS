
extend view entity ZR_CAL_MA with 
{
  @EndUserText.label: 'Result Calibration extended definition'
  case 
    when Calibration.result_code = 'P'  
      then cast('Passed' as abap.char(12))
    else cast('Failed' as abap.char( 12 ))  
  end as ZZResultLabelZ20
}
