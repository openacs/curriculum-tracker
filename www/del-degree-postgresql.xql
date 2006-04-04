<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="select_uos">
     <querytext>
       SELECT uos_id FROM ct_degree_uos_map WHERE degree_id = :degree_id
     </querytext>
   </fullquery>

   <fullquery name="select_ga">
     <querytext>
       SELECT ga_id FROM ct_uos_ga_map WHERE uos_id = :uos_id
     </querytext>
   </fullquery>

   <fullquery name="delete_uos">
     <querytext>
       SELECT ct_uos__del (:uos_id)
     </querytext>
   </fullquery>

   <fullquery name="delete_uos_map">
     <querytext>
       DELETE FROM ct_degree_uos_map WHERE uos_id = :uos_id
     </querytext>
   </fullquery>

   <fullquery name="delete_ga">
     <querytext>
       SELECT ct_ga__del (:ga_id)
     </querytext>
   </fullquery>

   <fullquery name="delete_ga_map">
     <querytext>
       DELETE FROM ct_uos_ga_map WHERE ga_id = :ga_id
     </querytext>
   </fullquery>

   <fullquery name="delete_degree">
     <querytext>
       SELECT ct_degree__del (:degree_id)
     </querytext>
   </fullquery>

</queryset>
