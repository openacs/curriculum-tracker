ad_page_contract {
    Page for displaying details for a specific Unit of Study.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-11-20
    @cvs-id $Id$
} {
    uos_id:integer
}

set package_id [ad_conn package_id]

# Retrieve Unit of Study details.
db_1row uos_details {}

# Create a multirow containing all the UoS details.
template::multirow create details label value

template::multirow append details [_ curriculum-tracker.name] $name
template::multirow append details [_ curriculum-tracker.code] $code
template::multirow append details [_ curriculum-tracker.year_offered] $year
template::multirow append details [_ curriculum-tracker.session] $session
template::multirow append details [_ curriculum-tracker.requirement] \
    $requirement
template::multirow append details [_ curriculum-tracker.lecturer] $lecturer
template::multirow append details [_ curriculum-tracker.objectives] $objectives
template::multirow append details [_ curriculum-tracker.outcomes] $outcomes
template::multirow append details [_ curriculum-tracker.syllabus] $syllabus

db_multirow attributes attributes {} {
    set ga_level [curriculum_tracker::ga_level_pretty_name -level $ga_level]
}

set return_url [export_vars -url -base view-uos { uos_id }]
set toggle_completed_url [export_vars -url -base toggle-uos-status \
			      { uos_id completed_p return_url }]


db_1row degree_info {}
set degree_return_url [export_vars -url -base view-degree { degree_id }]
set page_title "${code} ${name}"
set context [list [list $degree_return_url $stream_name] $page_title]

ad_return_template
