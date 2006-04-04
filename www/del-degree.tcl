ad_page_contract {
    Page for importing a degree.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-02
    @cvs-id $Id$
} {
    degree_id
    {return_url "."}
}

auth::require_login

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

permission::require_write_permission -object_id $degree_id -party_id $user_id

db_transaction {
    # Delete the degree.
    db_exec_plsql delete_degree {}
}    

ad_returnredirect -message "[_ curriculum-tracker.degree_deleted]" $return_url
