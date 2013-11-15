{**
 * selectReviewer.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List reviewers and give the ability to select a reviewer.
 *
 * $Id$
 *}
{strip}
{if $technicalReview == '1'}
{assign var="pageTitle" value="user.role.technicalReviewers"}
{else}
{assign var="pageTitle" value="user.role.reviewers"}
{/if}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
  document.submit.sort.value = heading;
  document.submit.sortDirection.value = direction;
  document.submit.submit() ;
}
// -->
$(document).ready(function(){
	if ( $('select[name="searchField"]').val() == 'interests' ){
		$('#searchTextField').hide();
		$('#searchDropDown').show();
		$('#searchTextField').val('');
		$('#searchMatch option[value="is"]').remove();
		$('#searchMatch option[value="startsWith"]').remove();
	} else {
		$('#searchTextField').show();
		$('#searchDropDown').hide();
		$("#searchDropDown option[value='']").attr("selected","selected");
		$("#searchMatch option").each(function(){
    		$(this).remove();
		});
		$("#searchMatch").append('<option value="contains"{if $searchMatch == "contains"} selected="selected"{/if}>{/literal}{translate key="form.contains"}{literal}</option>');
		$("#searchMatch").append('<option value="is"{if $searchMatch == "is"} selected="selected"{/if}>{/literal}{translate key="form.is"}{literal}</option>');
		$("#searchMatch").append('<option value="startsWith"{if $searchMatch == "startsWith"} selected="selected"{/if}>{/literal}{translate key="form.startsWith"}{literal}</option>');
	}
	
    $('select[name="searchField"]').change(
    	function(){
    		var answer = $('select[name="searchField"]').val();
    		if (answer == 'interests') {
				$('#searchTextField').hide();
				$('#searchDropDown').show();
				$('#searchTextField').val('');
				$('#searchMatch option[value="is"]').remove();
				$('#searchMatch option[value="startsWith"]').remove();    		
    		} else {
				$('#searchTextField').show();
				$('#searchDropDown').hide();
				$("#searchDropDown option[value='']").attr("selected","selected");
				$("#searchMatch option").each(function(){
    				$(this).remove();
				});
				$("#searchMatch").append('<option value="contains"{if $searchMatch == "contains"} selected="selected"{/if}>{/literal}{translate key="form.contains"}{literal}</option>');
				$("#searchMatch").append('<option value="is"{if $searchMatch == "is"} selected="selected"{/if}>{/literal}{translate key="form.is"}{literal}</option>');
				$("#searchMatch").append('<option value="startsWith"{if $searchMatch == "startsWith"} selected="selected"{/if}>{/literal}{translate key="form.startsWith"}{literal}</option>');
    		}
    	}
    );
});
{/literal}
</script>

{if $technicalReview == '1'}
	<form name="submit" method="post" action="{url op="selectReviewer" path=$articleId}">
		<input type="hidden" name="sort" value="id"/>
		<input type="hidden" name="sortDirection" value="ASC"/>
		<select name="searchField" size="1" class="selectMenu">
			{html_options_translate options=$fieldOptions selected=$searchField}
		</select>
		<select id="searchMatch" name="searchMatch" size="1" class="selectMenu">
			<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
			<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
			<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
		</select>
		<input id="searchTextField" type="text" size="10" name="search" class="textField" value="{$search|escape}" />
		<select id="searchDropDown" name="searchByDropDown" class="selectMenu">
			<option value="">{translate key="common.all"}<option>
    	    {foreach from=$reviewingInterests item=rInterest}
    	        <option value="{$rInterest.code}" {if $search == $rInterest.code}selected="selected"{/if}>{$rInterest.name}</option>
			{/foreach}
		</select>
		&nbsp;<input type="submit" value="{translate key="common.search"}" class="button" />
	</form>
	
	<p>{foreach from=$alphaList item=letter}<a href="{url op="selectReviewer" path=$articleId searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="selectReviewer" path=$articleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>
	
	<p><a class="action" href="{url op="createTechnicalReviewer" path=$articleId}">{translate key="editor.article.createTechnicalReview"}</a></p>
	
	<div id="reviewers">
		<table class="listing" width="100%">
		{assign var=numCols value=7}
		{if $rateReviewerOnQuality}
			{assign var=numCols value=$numCols+1}
		{/if}
		<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="20%">{sort_search key="user.name" sort="reviewerName"}</td>
			<td>{translate key="user.interests"}</td>
			{if $rateReviewerOnQuality}
				<td width="7%">{sort_search key="reviewer.averageQuality" sort="quality"}</td>
			{/if}
			<td width="7%">{sort_search key="reviewer.completedReviews" sort="done"}</td>
			<td width="7%">{sort_search key="editor.submissions.averageTime" sort="average"}</td>
			<td width="13%">{sort_search key="editor.submissions.lastAssigned" sort="latest"}</td>
			<td width="5%">{sort_search key="common.active" sort="active"}</td>
			<td width="7%" class="heading">{translate key="common.action"}</td>
		</tr>
		<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>
		
		{iterate from=reviewers item=reviewer}
		
			{assign var="userId" value=$reviewer->getId()}
			{assign var="qualityCount" value=$averageQualityRatings[$userId].count}
			{assign var="reviewerStats" value=$reviewerStatistics[$userId]}
			<tr valign="top">
				<td><a class="action" href="{url op="userProfile" path=$userId}">{$reviewer->getFullName()|escape}</a></td>
				<td>{$reviewer->getInterests()|urldecode|escape}</td>
				{if $rateReviewerOnQuality}<td>
					{if $qualityCount}{$averageQualityRatings[$userId].average|string_format:"%.1f"}
					{else}{translate key="common.notApplicableShort"}{/if}
				</td>{/if}
			
				<td>
					{if $completedReviewCounts[$userId]}
						{$completedReviewCounts[$userId]}
					{else}
						0
					{/if}
				</td>
		
				<td>
					{if $reviewerStats.average_span}
						{math equation="round(theSpan)" theSpan=$reviewerStats.average_span}
					{else}
						&mdash;
					{/if}
				</td>
				<td>{if $reviewerStats.last_notified}{$reviewerStats.last_notified|date_format:$dateFormatShort}{else}&mdash;{/if}</td>
				<td>{$reviewerStats.incomplete|default:0}</td>
				<td>
					{if $reviewer->review_id}
						{translate key="common.alreadyAssigned"}
					{else}
					<a class="action" href="{url op="selectReviewer" path=$articleId|to_array:$reviewer->getId()}">{translate key="common.assign"}</a>
					{/if}
				</td>
			</tr>
			<tr><td colspan="{$numCols|escape}" class="{if $reviewers->eof()}end{/if}separator">&nbsp;</td></tr>
		{/iterate}
		{if $reviewers->wasEmpty()}
			<tr><td colspan="{$numCols|escape}" class="nodata">{translate key="manager.people.noneEnrolled"}</td></tr>
			<tr><td colspan="{$numCols|escape}" class="endseparator">&nbsp;</td></tr>
		{else}
			<tr>
				<td colspan="2" align="left">{page_info iterator=$reviewers}</td>
				<td colspan="{$numCols-2}" align="right">{page_links anchor="reviewers" name="reviewers" iterator=$reviewers searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
		</table>
		<p><a class="action" href="{url op="submissionReview" path=$articleId} class="action">{translate key="editor.article.backToReview"}</a></p>
		<h4>{translate key="common.notes"}</h4>
		<p>{translate key="editor.article.selectReviewerNotes"}</p>
	</div>
{else}
	<div id="selectReviewer">
		<h3>{translate key="editor.article.selectReviewer"}</h3>
		<table class="listing">
			<tr><td colspan="3" class="headseparator">&nbsp;</td></tr>
			<tr>
				<td width="30%" class="heading" align="left">{translate key="user.name" sort="reviewerName"}</td>
				<td width="40%" class="heading" align="left">Reviewing interests</td>
				<td width="30%" class="heading" align="left">{translate key="common.action"}</td>
			</tr>	
			<tr><td colspan="3" class="headseparator">&nbsp;</td></tr>
			{assign var="count" value=0}
			{foreach from=$unassignedReviewers item=ercMember}
				{if ($submission->getSectionId()=='1' && $ercMember->isHsphMember()) || ($submission->getSectionId()=='2' && $ercMember->isCrecMember()) || $ercMember->isLocalizedTechnicalReviewer() == "Yes"}
					{assign var="count" value=$count+1}
					{assign var="reviewerId" value=$ercMember->getId()}
					<tr>
						<td width="30%" class="heading">{$ercMember->getFullname()|escape}</td>
						<td width="40%" class="heading">{$ercMember->getInterests()|urldecode|escape}</td>
						<td width="30%" class="heading" align="left">
							{if in_array($reviewerId, $reviewerIds)}
								{translate key="common.alreadyAssigned"}
							{else}
								<a href="{url op="selectReviewer" path=$articleId|to_array:$reviewerId}" class="action">{translate key="editor.article.assignAndNotify"}</a>
							{/if}
						</td>
					</tr>			
					<tr><td colspan="3" class="separator">&nbsp;</td></tr>
				{/if}
			{/foreach}
			{if $count==0}
				<tr>
					<td colspan="3" class="nodata">{translate key="common.none"}</td>
				</tr>
				<tr>
					<td colspan="3" class="endseparator">&nbsp;</td>
				</tr>
			{else}
				<tr>
					<td colspan="3" class="endseparator">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3" align="left">{$count} {translate key="user.role.reviewer"}</td>
				</tr>
			{/if}
		</table>
	</div>
	<p><a class="action" href="{url op="submissionReview" path=$articleId} class="action">{translate key="editor.article.backToReview"}</a></p>
{/if}
{include file="common/footer.tpl"}

