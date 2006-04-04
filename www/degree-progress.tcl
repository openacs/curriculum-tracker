ad_page_contract {
    Page for displaying progress for a specific degree.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-11-20
    @cvs-id $Id$
} {
    degree_id:integer
}

set package_id [ad_conn package_id]

set page_title "[_ curriculum-tracker.progress]"
set context $page_title

template::multirow create graduate_attributes name level width

db_foreach distinct_ga_name {} {
    set sum_level [db_string sum_level {} -default "0"]
    
    # Use a multiplier to scale the results.
    set multiplier 10

    if { $sum_level == ""} {
	set sum_level 0
    }
    set width [expr {$sum_level * $multiplier}]

    template::multirow append graduate_attributes $name $sum_level $width
}

template::multirow sort graduate_attributes -increasing name

ad_return_template
