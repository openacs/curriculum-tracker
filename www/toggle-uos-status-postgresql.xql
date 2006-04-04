<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="change_to_incomplete">
     <querytext>
       UPDATE ct_uos SET completed_p = 'false' WHERE uos_id = :uos_id
     </querytext>
   </fullquery>

   <fullquery name="change_to_complete">
     <querytext>
       UPDATE ct_uos SET completed_p = 'true' WHERE uos_id = :uos_id
     </querytext>
   </fullquery>

</queryset>
