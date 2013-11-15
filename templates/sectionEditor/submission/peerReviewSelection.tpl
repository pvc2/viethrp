{**
 * peerReview.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the peer review table.
 *
 * $Id$
 *}


<form method="post" action="{url op="selectReviewers" path=$submission->getId()}">
<div id="peerReview">
<table><tr><td><h3>Active ERC Members</h3></td></tr></table>
<table class="data" width="100%">
	<tr id="reviewersHeader" valign="middle">
		<td width="10%"></td>
		<td width="40%" valign="left"><h4>Name</h4></td>
		<td width="50%" valign="left"><h4>Reviewing Interests</h4></td>
	</tr>
</table>


{assign var="start" value="A"|ord}
{assign var="reviewIndex" value=0}
{foreach from=$reviewers item=reviewer}
{if ($submission->getSectionId()=='1' && $reviewer->isHsphMember()) || ($submission->getSectionId()=='2' && $reviewer->isCrecMember())}
	{assign var="isTechnicalReviewer" value=$reviewer->isLocalizedTechnicalReviewer()}
	{if $isTechnicalReviewer==null || $isTechnicalReviewer!="Yes"}
	{assign var="reviewIndex" value=$reviewIndex+1}
	<div class="separator"></div>
	<table class="data" width="100%">		
			<tr class="reviewer">
				<td class="r1" width="10%" align="center">
					<h4><input type="checkbox" id="reviewer_{$reviewIndex+$start|chr}" name="selectedReviewers[]" value="{$reviewer->getId()}" /></h4>					
				</td>
				<td class="r2" width="40%" align="left">
					<label for="reviewer_{$reviewIndex+$start|chr}"><h4>{$reviewer->getFullName()|escape}</h4></label>
				</td>	
				<td class="r3" width="50%" align="left">
					<label for="reviewer_{$reviewIndex+$start|chr}"><h7>{$reviewer->getUserInterests()|escape}</h7></label>
				</td>
			</tr>	
	</table>
	{/if}
{/if}
{/foreach}
<br/><input type="submit" class="button" value="Select And Notify ERC Members for Primary Review" />						
</form>
</div>
