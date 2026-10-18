CLASS zcl_cal_test_ma DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cal_test_ma IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


* DELETE FROM zcal_ma.

  MODIFY ENTITIES OF ZR_CAL_MA
    ENTITY CalibrationRequest
    CREATE FIELDS
        (
         InstrumentCode
         ResultCode
         CalibrationNote
        )
    WITH VALUE #(
       ( %cid            = 'CAL_1'
         InstrumentCode  = 'GAUGE-35'
         ResultCode      = 'F'
         CalibrationNote = 'Failed calibration check'
       )
       ( %cid            = 'CAL_2'
         InstrumentCode  = 'GAUGE-27'
         ResultCode      = 'P'
         CalibrationNote = 'Passed calibration check'
       )
    )
    MAPPED DATA(mapped)
    FAILED DATA(failed)
    REPORTED DATA(reported).


    DATA(uuid_a) = mapped-calibrationrequest[ %cid = 'CAL_1' ]-Uuid.
    DATA(uuid_b) = mapped-calibrationrequest[ %cid = 'CAL_2' ]-Uuid.

    READ ENTITIES OF ZR_CAL_MA
        ENTITY CalibrationRequest
        ALL FIELDS WITH VALUE #(
            ( Uuid = uuid_a )
            ( Uuid = uuid_b )
         )
        RESULT DATA(result_entity)
        FAILED DATA(failed_entity).

        out->write( result_entity ).
        out->write( failed_entity ).

    IF failed IS INITIAL.

        COMMIT ENTITIES RESPONSE OF ZR_CAL_MA
        FAILED DATA(save_failed)
        REPORTED DATA(save_reported).

        out->write( save_failed ).
        out->write( save_reported ).
    ELSE.
        out->write( failed ).
        out->write( reported ).
    ROLLBACK ENTITIES.
    ENDIF.


   READ ENTITIES OF ZR_CAL_MA
        ENTITY CalibrationRequest
        ALL FIELDS WITH VALUE #(
            ( Uuid = uuid_a )
            ( Uuid = uuid_b )
         )
        RESULT DATA(result_entity_after_commit)
        FAILED DATA(failed_entity_after_commit).

        out->write( result_entity_after_commit ).
        out->write( failed_entity_after_commit ).

  ENDMETHOD.

ENDCLASS.
