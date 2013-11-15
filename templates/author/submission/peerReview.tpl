{**
 * peerReview.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's peer review table.
 *
 * $Id$
 *}
<div id="peerReview">
<h3>{translate key="submission.peerReview"}</h3>

{assign var=start value="A"|ord}
{section name="round" loop=$submission->getCurrentRound()}
{assign var="round" value=$smarty.section.round.index+1}
{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}
{assign var="viewableFiles" value=$authorViewableFilesByRound[$round]}

<!--<h4>{translate key="submission.round" round=$round}</h4>-->
{assign var="status" value=$submission->getSubmissionStatus()}

<table class="data" width="100%">
	<tr valign="top">
		<td class="label" width="20%">
			{translate key="submission.technicalReview"}
		</td>
		<td class="value" width="80%">
			{if $status == PROPOSAL_STATUS_SUBMITTED || $status == PROPOSAL_STATUS_RESUBMITTED || $status == PROPOSAL_STATUS_DRAFT}
				{translate key="common.none"}<br/>
			{elseif $lastDecisionArray.technicalReview == 0}
				{translate key="submission.notRequired"}<br/>
			{elseif $status == PROPOSAL_STATUS_CHECKED}
				{translate key="submission.undergoing"}<br/>
			{elseif $status == PROPOSAL_STATUS_RETURNED}
				{translate key="submission.proposalIncomplete"}<br/>
			{else}
				{translate key="reviewer.article.decision.accept"}<br/>
			{/if}
			{foreach from=$viewableFiles item=reviewerFiles key=reviewer}
				{foreach from=$reviewerFiles item=viewableFilesForReviewer key=reviewId}
					{assign var="roundIndex" value=$reviewIndexesByRound[$round][$reviewId]}
					{assign var=thisReviewer value=$start+$roundIndex|chr}
					{foreach from=$viewableFilesForReviewer item=viewableFile}
						<!--{translate key="user.role.reviewer"} {$thisReviewer|escape}-->
						{if $viewableFile->getReviewType() == '4'}
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$viewableFile->getFileId():$viewableFile->getRevision()}" class="file">{$viewableFile->getFileName()|escape}</a>&nbsp;&nbsp;{$viewableFile->getDateModified()|date_format:$dateFormatLong}<br />
						{/if}
					{/foreach}
				{/foreach}
			{/foreach}
		</td>
	</tr>
	<tr valign="top">
		<td class="label" width="20%">
			{translate key="submission.ethicalReview"}
		</td>
		<td class="value" width="80%">
			{if $status == PROPOSAL_STATUS_SUBMITTED || $status == PROPOSAL_STATUS_RESUBMITTED || $status == PROPOSAL_STATUS_CHECKED}
				{translate key="common.none"}<br/>
			{elseif $status == PROPOSAL_STATUS_EXEMPTED}
				{translate key="editor.article.decision.exempted"}<br/>
			{elseif $status == PROPOSAL_STATUS_EXPEDITED}
				{translate key="submission.expeditedReviewUndergoing"}<br/>
			{elseif $status == PROPOSAL_STATUS_ASSIGNED}
				{translate key="submission.fullReviewUndergoing"}<br/>
			{elseif $status == PROPOSAL_STATUS_REVIEWED || PROPOSAL_STATUS_WITHDRAWN || PROPOSAL_STATUS_ARCHIVED || $status == PROPOSAL_STATUS_COMPLETED}
				{if $lastDecisionArray.decision == SUBMISSION_EDITOR_DECISION_ACCEPT}
					{translate key="reviewer.article.decision.accept"}<br/>
				{elseif $lastDecisionArray.decision == SUBMISSION_EDITOR_DECISION_DECLINE}
					{translate key="reviewer.article.decision.decline"}<br/>
				{elseif $lastDecisionArray.decision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
					{translate key="submission.reviseAndResubmit"}<br/>
				{/if}
			{/if}
			{foreach from=$viewableFiles item=reviewerFiles key=reviewer}
				{foreach from=$reviewerFiles item=viewableFilesForReviewer key=reviewId}
					{assign var="roundIndex" value=$reviewIndexesByRound[$round][$reviewId]}
					{assign var=thisReviewer value=$start+$roundIndex|chr}
					{foreach from=$viewableFilesForReviewer item=viewableFile}
						{if $viewableFile->getReviewType() != '4'}
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$viewableFile->getFileId():$viewableFile->getRevision()}" class="file">{$viewableFile->getFileName()|escape}</a>&nbsp;&nbsp;{$viewableFile->getDateModified()|date_format:$dateFormatLong}<br />
						{/if}
					{/foreach}
				{/foreach}
			{/foreach}
		</td>
	</tr>
	{if !$smarty.section.round.last}
		<tr valign="top">
			<td class="label" width="20%">
				{translate key="submission.editorVersion"}
			</td>
			<td class="value" width="80%">
				{foreach from=$editorFiles item=editorFile key=key}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorFile->getDateModified()|date_format:$dateFormatShort}<br />
				{foreachelse}
					{translate key="common.none"}
				{/foreach}
			</td>
		</tr>
		<tr valign="top">
			<td class="label" width="20%">
				{translate key="submission.authorVersion"}
			</td>
			<td class="value" width="80%">
				{foreach from=$authorFiles item=authorFile key=key}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$authorFile->getDateModified()|date_format:$dateFormatShort}<br />
				{foreachelse}
					{translate key="common.none"}
				{/foreach}
			</td>
		</tr>
	{/if}
</table>

{if !$smarty.section.round.last}
	<div class="separator"></div>
{/if}

{/section}
</div>
