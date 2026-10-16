CLASS lhc_CalibrationRequest DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS ZZcheckResultCode FOR VALIDATE ON SAVE
       keys FOR CalibrationRequest~ZZcheckResultCode.

ENDCLASS.

CLASS lhc_CalibrationRequest IMPLEMENTATION.

  METHOD ZZcheckResultCode.

    READ ENTITIES OF zr_cal_ma IN LOCAL MODE
       ENTITY CalibrationRequest
       ALL FIELDS
       WITH CORRESPONDING #( keys )
       RESULT DATA(requests).

       LOOP AT requests INTO DATA(request).

           IF request-ResultCode <> 'P' AND
              request-ResultCode <> 'N'.

             APPEND VALUE #(
                %tky = request-%tky
             ) TO failed-calibrationrequest.

             APPEND VALUE #(
                 %tky = request-%tky
                 %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Result Code must be P or N'
                 )
            %element-Resultcode = if_abap_behv=>mk-on
              ) TO reported-calibrationrequest.

            ENDIF.

       ENDLOOP.


  ENDMETHOD.

ENDCLASS.
