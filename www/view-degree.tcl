ad_page_contract {
    Page for viewing the curriculum for a specific degree.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-02
    @cvs-id $Id$
} {
    degree_id
}

set package_id [ad_conn package_id]
set owner_id [ad_conn user_id]


db_multirow -extend { ys_group view_uos_url } curriculum select_curriculum {} {
    set ys_group "${year}${session}"
    set view_uos_url [export_vars -url -base view-uos { uos_id }]
}

set stream_name [db_string select_degree {}]
set page_title $stream_name
set context [list $page_title]

ad_return_template
