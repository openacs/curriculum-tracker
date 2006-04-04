ad_page_contract {
    Page for importing a degree.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-02
    @cvs-id $Id$
} {
    curriculum_file
    {curriculum_file.tmpfile}
    return_url
}

set package_id [ad_conn package_id]
set owner_id [ad_conn user_id]

if { $curriculum_file == ""} {
    ad_returnredirect -message [_ curriculum-tracker.no_file_found_for_upload] $return_url
}

set failed_p [ catch {curriculum_tracker::parse_degree_file -xmlfile ${curriculum_file.tmpfile}} errMsg]

if { $failed_p } {
    set message "[_ curriculum-tracker.import_failed]: $errMsg"
    ns_log Error "Curriculum Tracker: $errMsg"
} else {
    set message [_ curriculum-tracker.import_succeeded]
}

ad_returnredirect -message $message $return_url
