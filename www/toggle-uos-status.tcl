ad_page_contract {
    Toggles 

    @param uos_id The ID for the UoS that we want to toggle the status value
    for.
    @param completed_p The current status of the given UoS.
    @param return_url The URL to return to after toggling the UoS status.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-02
    @cvs-id $Id$
} {
    uos_id
    completed_p
    return_url
}

set package_id [ad_conn package_id]
set owner_id [ad_conn user_id]

if { $completed_p } {
    # Change to incomplete
    db_dml change_to_incomplete {}
    set message "[_ curriculum-tracker.status_changed_to_incomplete]"
} else {
    # Change to complete
    db_dml change_to_complete {}
    set message "[_ curriculum-tracker.status_changed_to_complete]"
}

ad_returnredirect -message $message $return_url
