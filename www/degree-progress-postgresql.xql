<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="distinct_ga_name">
     <querytext>
       SELECT DISTINCT name FROM ct_ga WHERE package_id = :package_id
     </querytext>
   </fullquery>

   <fullquery name="sum_level">
     <querytext>
       SELECT SUM(ga.level)
       FROM ct_ga ga, ct_uos_ga_map ug, ct_degree_uos_map du, ct_uos u
       WHERE ga.ga_id = ug.ga_id
       AND du.uos_id = ug.uos_id
       AND du.degree_id = :degree_id
       AND u.uos_id = du.uos_id
       AND ga.name = :name
       AND u.completed_p
       AND ga.package_id = :package_id
     </querytext>
   </fullquery>

</queryset>
