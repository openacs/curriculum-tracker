<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="select_degree">
     <querytext>
       SELECT stream_name FROM ct_degree WHERE degree_id = :degree_id
     </querytext>
   </fullquery>

   <fullquery name="select_curriculum">
     <querytext>
       SELECT u.uos_id, u.year, u.session, u.code, u.name, u.completed_p
       FROM ct_degree_uos_map dumap
       left outer join ct_uos u on (dumap.uos_id = u.uos_id)
       WHERE dumap.degree_id = :degree_id
       AND u.package_id = :package_id
       ORDER BY u.year ASC, u.session ASC, u.code ASC
     </querytext>
   </fullquery>

</queryset>
