<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="displayed_object_id">@uos_id;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/curriculum-tracker/curriculum-tracker.css" media="all">
</property>


<div id="ct-status-container">

<if @completed_p;literal@ true>
<div class="complete">
<ul>
<li>#curriculum-tracker.status_complete#</li>
<li><a href="@toggle_completed_url@" class="button">#curriculum-tracker.change_to_incomplete#</a></li>
</ul>
</div>
</if>
<else>
<div class="incomplete">
<ul>
<li>#curriculum-tracker.status_incomplete#</li>
<li><a href="@toggle_completed_url@" class="button">#curriculum-tracker.change_to_complete#</a></li>
</ul>
</div>
</else>
</div>

<div id="ct-list-container">
  <h3>#curriculum-tracker.uos_details#</h3>
  <table>
    <multiple name="details">
    <tr>
      <td class="label">@details.label;noquote@</td>
      <td class="value"><if @details.value@ ne "">@details.value;noquote@</if><else>&nbsp;</else></td>
    </tr>
    </multiple>
  </table>

  <h3>#curriculum-tracker.graduate_attributes#</h3>
  <table>
    <tr>
      <th>#curriculum-tracker.name#</th>
      <th>#curriculum-tracker.level#</th>
      <th>#curriculum-tracker.description#</th>
    </tr>
    <multiple name="attributes">
    <tr>
      <td class="label">@attributes.ga_name;noquote@</td>
      <td class="value"><if @attributes.ga_level@ ne "">@attributes.ga_level;noquote@</if><else>&nbsp;</else></td>
      <td class="value"><if @attributes.ga_description@ ne "">@attributes.ga_description;noquote@</if><else>&nbsp;</else></td>
    </tr>
    </multiple>
  </table>
</div>
