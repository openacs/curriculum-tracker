<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="curriculum_tracker::parse_degree_file.map_uos_to_degree">
     <querytext>
       INSERT INTO ct_degree_uos_map (degree_id, uos_id) 
       VALUES (:degree_id, :uos_id);
     </querytext>
   </fullquery>

   <fullquery name="curriculum_tracker::parse_degree_file.map_ga_to_uos">
     <querytext>
       INSERT INTO ct_uos_ga_map (uos_id, ga_id) VALUES (:uos_id, :ga_id);
     </querytext>
   </fullquery>

</queryset>
