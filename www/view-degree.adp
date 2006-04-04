<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/curriculum-tracker/curriculum-tracker.css" media="all">
</property>


<div id="ct-map-container">

  <div class="spacer">&nbsp;</div>

  <div id="key">
    #curriculum-tracker.status_of_completed_uos_key#
    <ul>
      <li class="complete">#curriculum-tracker.complete#</li>
      <li class="incomplete">#curriculum-tracker.incomplete#</li>
    </ul>
    <h3>#curriculum-tracker.key#</h3>
  </div>

  <multiple name="curriculum">
  <ul class="years">
    <li>@curriculum.year@</li>

    <ul class="sessions">
    <group column="year">
      <li>@curriculum.session@</li>

      <ul id="uos">
        <group column="ys_group">
        <if @curriculum.completed_p@>
	<div class="float complete">
        </if>
        <else>
        <div class="float incomplete">
        </else>
          <ul class="info">
	    <li class="uos-code">@curriculum.code@</li>
            <li class="uos-name">@curriculum.name@</li>
          </ul>
          <ul class="options">
            <li class="info"><a href="@curriculum.view_uos_url@" class="button">#curriculum-tracker.view_details#</a></li>
          </ul>
        </div>
        </group>

	<div class="spacer">&nbsp;</div>
      </ul>
    </group>
    </ul>
  </ul>
  </multiple>  

</div>
