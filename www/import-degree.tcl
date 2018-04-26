ad_page_contract {
    Page for importing a degree.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-02
    @cvs-id $Id$
} {
    {return_url "."}
}

set page_title "[_ curriculum-tracker.import_degree]"
set context {}
set package_id [ad_conn package_id]
set owner_id [ad_conn user_id]

ad_form -cancel_url . -name import_degree -action {import-degree-2} -html {enctype multipart/form-data} -form {
    {return_url:text(hidden) {value $return_url}}
    {curriculum_file:file
	{label "[_ curriculum-tracker.upload_curriculum_file]"}
	{help_text "[_ curriculum-tracker.help_upload_curriculum_file]"}
	{html "size 30"}
    }
} -after_submit {
    ad_script_abort
}

ad_return_template
