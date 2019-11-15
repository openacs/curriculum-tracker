<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/curriculum-tracker/curriculum-tracker.css" media="all">
</property>

<if @imported_degrees_p;literal@ true>
#curriculum-tracker.select_a_curriculum_to_view#
<p />
<div id="ct-degree-container">

  <ul id="degrees">
    <multiple name="degrees">
    <li><span class="label"><a href="@degrees.view_degree_url@">@degrees.stream_name@</a></span><span class="options">[<a href="@degrees.progress_url@">#curriculum-tracker.view_progress#</a>] [<a href="@degrees.del_degree_url@" onclick="return confirm('#curriculum-tracker.confirm_delete_degree#');">#curriculum-tracker.delete#</a>]</span><div class="spacer"></div></li>
    </multiple>
  </ul>

</div>
</if>
<else>
No degrees have been imported.
</else>
<p />

<a href="import-degree">#curriculum-tracker.import_degree#</a>
