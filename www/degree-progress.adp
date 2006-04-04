<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/curriculum-tracker/curriculum-tracker.css" media="all">
</property>


<center>
<div id="ct-barchart-container">

<table cellspacing="0" cellpadding="0">
      <caption align="top">#curriculum-tracker.graduate_attributes_progress_caption#<br /><br /></caption>
      <tr>
        <th scope="col"><span >#curriculum-tracker.graduate_attribute#</span> </th>
        <th scope="col"><span >#curriculum-tracker.accumulated_development_of_graduate_attributes#</span> </th>

      </tr>

      <multiple name="graduate_attributes">
      <tr>
	<if @graduate_attributes.rownum@ eq 1>
	<td class="first">@graduate_attributes.name@</td>
        <td class="value first"><img src="/resources/curriculum-tracker/images/bar.png" alt="" width="@graduate_attributes.width@" height="16" />@graduate_attributes.level@</td>
	</if>
	<elseif @graduate_attributes.rownum@ eq @graduate_attributes:rowcount@>
	<td>@graduate_attributes.name@</td>
        <td class="value last"><img src="/resources/curriculum-tracker/images/bar.png" alt="" width="@graduate_attributes.width@" height="16" />@graduate_attributes.level@</td>
	</elseif>
	<else>
	<td>@graduate_attributes.name@</td>
        <td class="value"><img src="/resources/curriculum-tracker/images/bar.png" alt="" width="@graduate_attributes.width@" height="16" />@graduate_attributes.level@</td>
	</else>
      </tr>
      </multiple>

    </table>

</div>
</center>
