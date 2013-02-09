{**
 * status.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission status table.
 *}
<div id="status">
<h3>{translate key="common.status"}</h3>

<table width="100%" class="data">
	<tr>
		{assign var="status" value=$submission->getSubmissionStatus()}
		<td title="Current review status of the proposal" width="20%" class="label">[?] {translate key="common.status"}</td>
		<td width="80%" class="value">

                        <!-- Edited by: AIM, July 4 2011 -->
                        {if $status==PROPOSAL_STATUS_DRAFT}{translate key="submissions.proposal.draft"}
                        {elseif $status==PROPOSAL_STATUS_WITHDRAWN}{translate key="submissions.proposal.withdrawn"}
                        {elseif $status==PROPOSAL_STATUS_COMPLETED}{translate key="submissions.proposal.completed"}
                        {elseif $status==PROPOSAL_STATUS_ARCHIVED}
                            {assign var="decision" value=$submission->getMostRecentDecision()}
                            {if $decision==SUBMISSION_EDITOR_DECISION_DECLINE}
                                {translate key="submission.archived"}({translate key="submissions.proposal.decline"})
                            {elseif $decision==SUBMISSION_EDITOR_DECISION_EXEMPTED}
                                {translate key="submission.archived"}({translate key="submissions.proposal.exempted"})
                            {/if}
                        {elseif $status==PROPOSAL_STATUS_SUBMITTED}{translate key="submissions.proposal.submitted"}
                        {elseif $status==PROPOSAL_STATUS_CHECKED}{translate key="submissions.proposal.checked"}
                        {elseif $status==PROPOSAL_STATUS_EXPEDITED}{translate key="submissions.proposal.expedited"}
                        {elseif $status==PROPOSAL_STATUS_ASSIGNED}{translate key="submissions.proposal.assigned"}
                        {elseif $status==PROPOSAL_STATUS_RETURNED}{translate key="submissions.proposal.returned"}
                        <br/><a href="{url op="resubmit" path=$submission->getId()}" class="action">Resubmit</a>
                        {elseif $status==PROPOSAL_STATUS_EXEMPTED}{translate key="submissions.proposal.exempted"}
                        {elseif $status==PROPOSAL_STATUS_REVIEWED}
                            {assign var="decision" value=$submission->getMostRecentDecision()}
                            {if $decision==SUBMISSION_EDITOR_DECISION_RESUBMIT}{translate key="submissions.proposal.resubmit"}
                       		 <br/><a href="{url op="resubmit" path=$submission->getId()}" class="action">Resubmit</a>
                            {elseif $decision==SUBMISSION_EDITOR_DECISION_ACCEPT}{translate key="submissions.proposal.approved"}
                            {elseif $decision==SUBMISSION_EDITOR_DECISION_DECLINE}{translate key="submissions.proposal.decline"}
                            
                            {/if}
                        {/if}
		</td>
	</tr>
	{if $status == PROPOSAL_STATUS_WITHDRAWN}
		<tr>
			<td class="label">&nbsp;</td>
			<td class="value">{translate key="common.reason"}: 
				{if $submission->getWithdrawReason(en_US) == "0"}
					{translate key="submission.withdrawLack"}
				{elseif $submission->getWithdrawReason(en_US) == "1"}
					{translate key="submission.withdrawAdverse"}
				{else}
					{$submission->getWithdrawReason(en_US)}
				{/if}
			</td>
		</tr>
		{if $submission->getWithdrawComments(en_US)}
			<tr>
				<td class="label">&nbsp;</td>
				<td class="value">{translate key="common.comments"}: {$submission->getWithdrawComments(en_US)}</td>
			</tr>
		{/if}
	{/if}
	<tr>
		<td class="label">{translate key="common.date"}</td>
		<td colspan="2" class="value">{$submission->getDateStatusModified()|date_format:$dateFormatLong}</td>
	</tr>

</table>
</div>

