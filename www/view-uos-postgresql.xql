<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="uos_details">
     <querytext>
       SELECT uos_id, name, code, year, session, lecturer, objectives,
           outcomes, syllabus, requirement, completed_p
       FROM ct_uos
       WHERE uos_id = :uos_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

   <fullquery name="attributes">
     <querytext>
       SELECT ga.name AS ga_name, ga.description AS ga_description,
           ga.level AS ga_level
       FROM ct_ga ga, ct_uos_ga_map ug
       WHERE ga.ga_id = ug.ga_id
       AND uos_id = :uos_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

   <fullquery name="degree_info">
     <querytext>
       SELECT DISTINCT d.stream_name AS stream_name, d.degree_id
       FROM ct_degree d, ct_degree_uos_map du
       WHERE d.degree_id = du.degree_id
       AND du.uos_id = :uos_id
       AND package_id = :package_id
       LIMIT 1
     </querytext>
   </fullquery>

</queryset>
