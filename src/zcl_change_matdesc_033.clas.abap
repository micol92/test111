CLASS zcl_change_matdesc_033 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_change_matdesc_033 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA product_detail TYPE TABLE FOR CREATE I_ProductTP_2.

    product_detail = VALUE #( (
     %cid = 'product1'
     Product = 'CUSTOM_PRODUCT'
     %control-Product = if_abap_behv=>mk-on
     ProductType = 'FERT'
     %control-ProductType = if_abap_behv=>mk-on
     BaseUnit = 'EA'
     %control-BaseUnit = if_abap_behv=>mk-on
     IndustrySector = 'M'
     %control-IndustrySector = if_abap_behv=>mk-on
     ) ).

     MODIFY ENTITIES OF I_ProductTP_2
     ENTITY Product
     CREATE FROM product_detail
     CREATE BY \_ProductDescription
     FIELDS ( Language ProductDescription ) WITH VALUE #( (
     %cid_ref = 'product1'
     Product = 'CUSTOM_PRODUCT'
     %target = VALUE #(
     (
     %cid = 'desc1'
     Product = 'CUSTOM_PRODUCT'
     Language = 'E'
     ProductDescription = 'Custom product created with ABAP Cloud'
     )
     (
     %cid = 'desc2'
     Product = 'CUSTOM_PRODUCT'
     Language = 'D'
     ProductDescription = 'Custom product created with ABAP Cloud'
     )
     )
     ) )

     MAPPED DATA(mapped)
     REPORTED DATA(reported)
     FAILED DATA(failed).

    COMMIT ENTITIES
     RESPONSE OF I_ProductTP_2
       FAILED DATA(failed_commit)
       REPORTED DATA(reported_commit).

* The following code can be used to update description of an existing product
*    MODIFY ENTITIES OF I_ProductTP_2
*        ENTITY ProductDescription
*        UPDATE FIELDS ( ProductDescription )
*        WITH VALUE #( ( %key-Product = 'DUMMY_PRODUCT_XXX'
*                        %key-Language = 'E'
*                        ProductDescription = 'Dummy Product XXX- Updated') )
*
*        REPORTED DATA(reported)
*        FAILED DATA(failed).
*
*    COMMIT ENTITIES
*      RESPONSE OF I_ProductTP_2
*          FAILED DATA(failed_commit)
*          REPORTED DATA(reported_commit).

  ENDMETHOD.
ENDCLASS.
