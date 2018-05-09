ad_page_contract {
    Page for viewing a list of imported curricula.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-02
    @cvs-id $Id$
}

set page_title [ad_conn instance_name]
set context [list]
set package_id [ad_conn package_id]
set owner_id [ad_conn user_id]

# Get list of degrees.
db_multirow -extend { view_degree_url del_degree_url progress_url } degrees degrees {} {
    set view_degree_url [export_vars -url -base view-degree {degree_id}]
    set del_degree_url [export_vars -url -base del-degree {degree_id}]
    set progress_url [export_vars -url -base degree-progress {degree_id}]
}

set imported_degrees_p 0
if { [template::multirow size degrees] > 0 } {
    set imported_degrees_p 1
}

ad_return_template
