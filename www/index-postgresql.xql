<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="degrees">
     <querytext>
       SELECT degree_id, stream_name FROM ct_degree
       WHERE owner_id = :owner_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

</queryset>
