ad_library {

    Curriculum Tracker Library

    @creation-date 2006-04-02
    @author Nick Carroll <ncarroll@ee.usyd.edu.au>
    @cvs-id bug-tracker-procs.tcl,v 1.13.2.7 2003/03/05 18:13:39 lars Exp

}

namespace eval curriculum_tracker {}


ad_proc curriculum_tracker::parse_degree_file {
    -xmlfile
    {-package_id {}}
    {-user_id {}}
} {
    Parses a degree file, and imports the curriculum information into the
    database.

    @param file_location Location of the degree file.
    @param package_id The package ID for an instance of Curriculum Tracker.
    @return Returns 1 if import succeeded, otherwise 0 is returned.
} {
    db_transaction {
	if { $package_id == "" } {
	    set package_id [ad_conn package_id]
	}
	
	if { $user_id == "" } {
	    set user_id [ad_conn user_id]
	}
	
	# Parser
	dom parse [::tdom::xmlReadFile $xmlfile] document
	
	# DOM document = DOM root
	$document documentElement root
	
	# Get degree details
	set faculty [[$root selectNodes {/degree/faculty[1]}] text]
	set department [[$root selectNodes {/degree/department[1]}] text]
	set stream [[$root selectNodes {/degree/stream[1]}] text]
	
	set degree_id [package_instantiate_object \
			   -var_list [list [list package_id $package_id] \
					  [list owner_id $user_id] \
					  [list faculty_name $faculty] \
					  [list department_name $department] \
					  [list stream_name $stream]] \
			   ct_degree]
	
	# Parse uos node
	foreach uos_node [$root selectNodes {/degree/uos}] {
	    set requirement [$uos_node getAttribute requirement]
	    set year [$uos_node getAttribute year]
	    set session [$uos_node getAttribute session]
	    
	    set name [[$uos_node selectNodes {name[1]}] text]
	    set code [[$uos_node selectNodes {code[1]}] text]
	    set objectives [[$uos_node selectNodes {objectives[1]}] text]
	    set outcomes [[$uos_node selectNodes {outcomes[1]}] text]
	    set syllabus [[$uos_node selectNodes {syllabus[1]}] text]
	    set lecturer [[$uos_node selectNodes {lecturer[1]}] text]
	    
	    set uos_id [package_instantiate_object \
			    -var_list [list [list package_id $package_id] \
					   [list name $name] \
					   [list code $code] \
					   [list year $year] \
					   [list session $session] \
					   [list requirement $requirement] \
					   [list lecturer $lecturer] \
					   [list objectives $objectives] \
					   [list outcomes $outcomes] \
					   [list syllabus $syllabus]] \
			    ct_uos]
	    
	    # Map uos_id to degree_id
	    db_dml map_uos_to_degree {}
	    
	    # Parse graduateAttributes node
	    foreach ga_node [$uos_node selectNodes \
				 {graduateAttributes/attribute}] {
		set name [[$ga_node selectNodes {name[1]}] text]
		set level [[$ga_node selectNodes {level[1]}] text]
		set description [[$ga_node selectNodes {description[1]}] text]
		
		set ga_id [package_instantiate_object \
			       -var_list [list [list package_id $package_id] \
					  [list name $name] \
					  [list level $level] \
					  [list description $description]] \
			       ct_ga]
		
		# Map ga_id to uos_id
		db_dml map_ga_to_uos {}
	    }
	}
	
	return 1
    }
}

ad_proc curriculum_tracker::ga_level_pretty_name {
    -level
} {
    Returns the pretty name for a given graduate attribute.

    @param level The graduate attribute level.
    @return Returns the pretty name for the given graduate attribute level.
} {
    if { $level == 1 } {
	return [_ curriculum-tracker.very_low]
    } elseif { $level == 2 } {
	return [_ curriculum-tracker.low]
    } elseif { $level == 3 } {
	return [_ curriculum-tracker.moderate]
    } elseif { $level == 4 } {
	return [_ curriculum-tracker.high]
    }

    return [_ curriculum-tracker.very_high]
}