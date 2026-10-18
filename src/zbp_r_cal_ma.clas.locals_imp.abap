CLASS lhc_calibrationrequest DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS setResponsibleUser FOR DETERMINE ON MODIFY
      keys FOR CalibrationRequest~setResponsibleUser.

ENDCLASS.

CLASS lhc_calibrationrequest IMPLEMENTATION.

  METHOD setResponsibleUser.

  DATA current_user TYPE abp_creation_user.
  current_user = cl_abap_context_info=>get_user_technical_name(  ).

  DATA updates TYPE TABLE FOR UPDATE zr_cal_ma.

  READ ENTITIES OF zr_cal_ma IN LOCAL MODE
    ENTITY CalibrationRequest
    FIELDS ( ResponsibleUser )
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    LOOP AT requests INTO DATA(request)
    WHERE ResponsibleUser IS INITIAL.

    APPEND VALUE #(
        %tky = request-%tky
        ResponsibleUser = current_user
    ) TO updates.

    IF updates IS NOT INITIAL.

      MODIFY ENTITIES OF zr_cal_ma IN LOCAL MODE
        ENTITY CalibrationRequest
        UPDATE FIELDS ( ResponsibleUser )
        WITH updates.

    ENDIF.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.


