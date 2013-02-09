{**
 * editorDecision.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the editor decision table.
 *
 * $Id$
 *}
<script type="text/javascript" src="{$baseUrl|cat:"/lib/pkp/js/lib/jquery/jquery-ui-timepicker-addon.js"}"></script>
<style type="text/css" src="{$baseUrl|cat:"/lib/pkp/styles/jquery-ui-timepicker-addon.css"}"></style>

{literal}
<script type="text/javascript">
$(document).ready(function() {
	$("#approvalDateRow").hide();
	$("#approvalDate").datepicker({changeMonth: true, changeYear: true, dateFormat: 'yy-mm-dd'});
	$("#decision").change(
		function() {
			var decision = $("#decision option:selected").val();
			if(decision == 1) {
				$("#approvalDateRow").show();
			} else {
				$("#approvalDateRow").hide();
			}
		}
	);	
});
function showOrHideTechnicalReview(value){
	if (value != '4') {
		document.getElementById('technicalReviewField').style.display = 'none';
		document.getElementById('submitComplete').style.display = 'none';
		document.getElementById('submitIncomplete').style.display = '';
	} else {
		document.getElementById('technicalReviewField').style.display = '';
		document.getElementById('submitComplete').style.display = '';
		document.getElementById('submitIncomplete').style.display = 'none';			
	}
}
function showOrHideEthicalReview(value){
	if (value == '4') {
		document.getElementById('ethicalReviewField').style.display = '';
		document.getElementById('notFullReview').style.display = '';
		document.getElementById('submitTechIncomplete').style.display = 'none';		
	} else {
		document.getElementById('ethicalReviewField').style.display = 'none';
		document.getElementById('notFullReview').style.display = 'none';
		document.getElementById('submitTechIncomplete').style.display = '';		
	}
}

function checkSize(){
	var fileToUpload = document.getElementById('finalDecisionFile');
	var check = fileToUpload.files[0].fileSize;
	var valueInKb = Math.ceil(check/1024);
	if (check > 5242880){
		alert ('{/literal}{translate key="common.fileTooBig1"}{literal}'+valueInKb+'{/literal}{translate key="common.fileTooBig2"}{literal}5 Mb.');
		return false
	} 
}
</script>
{/literal}
 
{assign var="proposalStatus" value=$submission->getSubmissionStatus()}
{assign var="proposalStatusKey" value=$submission->getProposalStatusKey($proposalStatus)}

{if $proposalStatus != PROPOSAL_STATUS_SUBMITTED && $proposalStatus != PROPOSAL_STATUS_RESUBMITTED && $proposalStatus != PROPOSAL_STATUS_CHECKED}
	{include file="sectionEditor/submission/technicalReview.tpl"}
	<div class="separator"></div>
{/if}

{if $proposalStatus == PROPOSAL_STATUS_REVIEWED}
	{include file="sectionEditor/submission/ethicalReview.tpl"}
	<div class="separator"></div>
{/if}

{if $proposalStatus == PROPOSAL_STATUS_CHECKED && $lastDecisionArray.technicalReview == 1} 
	{include file="sectionEditor/submission/peerReviewTechnical.tpl"}
	<div class="separator"></div>
{/if}

{if $proposalStatus == PROPOSAL_STATUS_ASSIGNED || $proposalStatus == PROPOSAL_STATUS_EXPEDITED} 
	{include file="sectionEditor/submission/peerReview.tpl"}
	<div class="separator"></div>
{/if}

{if $authorFees}
	{include file="sectionEditor/submission/authorFees.tpl"}
	<div class="separator"></div>
{/if}

<div id="editorDecision">
<h3>{translate key="submission.editorDecision"}</h3>

<table id="table1" width="100%" class="data">
	<tr valign="top" id="proposalStatus">
		<td title="{translate key="submission.proposalStatusInstruct"}" class="label" width="20%">[?] {translate key="submission.proposalStatus"}</td>
		<td width="80%" class="value">
		{translate key=$proposalStatusKey}
		{if $submission->isDueForReview()==1 && $proposalStatus != PROPOSAL_STATUS_COMPLETED}
			({translate key="submissions.proposal.forContinuingReview"})
		{/if}</td>
	</tr>
	<form method="post" action="{url op="recordDecision"}" onSubmit="return checkSize()" enctype="multipart/form-data">
		<input type="hidden" name="articleId" value="{$submission->getId()}" />
		<input type="hidden" name="lastDecisionId" value="{$lastDecisionArray.editDecisionId}" />
		<input type="hidden" name="resubmitCount" value="{$lastDecisionArray.resubmitCount}" />
 
	<tr valign="top" id="initialReview">
	{if $proposalStatus == PROPOSAL_STATUS_SUBMITTED || $proposalStatus == PROPOSAL_STATUS_RESUBMITTED }
		<td title="{translate key="editor.article.selectInitialReviewInstruct"}" class="label" width="20%">[?] {translate key="editor.article.selectInitialReview"}</td>
		<td width="80%" class="value">
			<select id="decision" name="decision" size="1" class="selectMenu" onchange="showOrHideTechnicalReview(this.value);">
				{html_options_translate options=$initialReviewOptions selected=1}
			</select>
			<input id="submitIncomplete" type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmInitialReview"}')" name="submit" value="{translate key="editor.article.record"}"  class="button" />			
		</td>
	<!-- New status for technical Review -->
	</tr>
	<tr valign="top" id="technicalReviewField" style="display: none;">
		<td title="{translate key="editor.article.selectTechnicalReviewInstruct"}" class="label" width="20%">[?] {translate key="common.technicalReview"}</td>
		<td width="80%" class="value">
			<select id="technicalReview" name="technicalReview" size="1" class="selectMenu">
				<option value="1">{translate key="common.required"}</option>
				<option value="2">{translate key="editor.article.decision.notRequired"}</option>
			</select>
			<input id="submitComplete" type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmInitialReview"}')" name="submit" value="{translate key="editor.article.record"}"  class="button" />
		</td>
	<!-- End of new status -->
	
	{elseif $proposalStatus == PROPOSAL_STATUS_CHECKED}
		{if $lastDecisionArray.technicalReview == 1}
		<td title="{translate key="editor.article.technicalReviewDecisionInstruct"}" width="20%">[?] {translate key="editor.article.selectTechnicalReview"}</td>
		<td width="80%" class="value">
			<select id="decision" name="techReviewDecision" size="1" class="selectMenu" onchange="showOrHideEthicalReview(this.value);">
				<option value=""></option>
				<option value="4">{translate key="editor.article.decision.accept"}</option>
				<option value="5">{translate key="editor.article.decision.incomplete"}</option>
			</select>
			<input id="submitTechIncomplete" type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmInitialReview"}')" name="submit" value="{translate key="editor.article.record"}"  class="button" />
		</td>
	</tr>
	<tr id="ethicalReviewField" style="display: none;">
		{/if}
		<td title="{translate key="editor.article.selectReviewProcessInstruct"}" class="label" width="20%">[?] {translate key="editor.article.selectReviewProcess"}</td>
		<td width="80%" class="value">
			<select id="decision" name="decision" size="1" class="selectMenu">
				{html_options_translate options=$exemptionOptions selected=1}
			</select>
			<input type="submit" id="notFullReview" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmExemption"}')" name="submit" value="{translate key="editor.article.record"}"  class="button" />
		</td>
	{elseif $proposalStatus == PROPOSAL_STATUS_REVIEWED && $submission->isDueForReview()==1}
		<td class="label" width="20%">{translate key="editor.article.selectContinuingReview"}</td>
		<td width="80%" class="value">
				<select id="decision" name="decision" size="1" class="selectMenu">
					{html_options_translate options=$continuingReviewOptions selected=1}
				</select>
				<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmReviewSelection"}')" name="submit" value="{translate key="editor.article.record"}"  class="button" />
		</td>
	{elseif ($articleMoreRecent && $proposalStatus == PROPOSAL_STATUS_REVIEWED && $lastDecisionArray.decision == SUBMISSION_EDITOR_DECISION_RESUBMIT)}
		<td title="{translate key="editor.article.selectDecisionInstruct"}" class="label" width="20%">[?] {translate key="editor.article.selectDecision"}</td>
		<td width="80%" class="value">
				<select id="decision" name="decision" size="1" class="selectMenu">
					{html_options_translate options=$editorDecisionOptions selected=0}
				</select>
				<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.recordDecision"}"  class="button" />
		</td>	
	{/if}
	</tr>

{if $proposalStatus == PROPOSAL_STATUS_WITHDRAWN}
	<tr id="withdrawnReasons">
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
		<tr id="withdrawComments">
			<td class="label">&nbsp;</td>
			<td class="value">{translate key="common.comments"}: {$submission->getWithdrawComments(en_US)}</td>
		</tr>
	{/if}
{/if}

{if $proposalStatus == PROPOSAL_STATUS_EXPEDITED || $proposalStatus == PROPOSAL_STATUS_ASSIGNED}	
	<tr id="finalDecision">
		<td title="{translate key="editor.article.selectDecisionInstruct"}" class="label" width="20%">[?] {translate key="editor.article.selectDecision"}</td>
		<td width="80%" class="value">
			<select id="decision" name="decision" {if $authorFees && !$submissionPayment && $submission->getLocalizedStudentInitiatedResearch() != 'Yes'}disabled="disabled"{/if} size="1" class="selectMenu">
				{html_options_translate options=$editorDecisionOptions selected=0}
			</select> {if $authorFees && !$submissionPayment && $submission->getLocalizedStudentInitiatedResearch() != 'Yes'}<i>{translate key="manager.payment.paymentConfirm"}</i>{/if}
{*			
			<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.uploadRecordDecision"}"  class="button" />				
*}			
		</td>		
	</tr>
{/if}
	<tr id="approvalDateRow">
		<td title="{translate key="editor.article.setApprovalDateInstruct"}" class="label">[?] {translate key="editor.article.setApprovalDate"}</td>
		<td class="value">
			<input type="text" name="approvalDate" id="approvalDate" class="textField" size="19" />
		</td>
	</tr>
{if $proposalStatus == PROPOSAL_STATUS_EXPEDITED || $proposalStatus == PROPOSAL_STATUS_ASSIGNED}	
	<tr id="uploadFinalDecision">
		<td title="{translate key="editor.article.uploadFinalDecisionFileInstruct"}" class="label" width="20%">[?] {translate key="editor.article.uploadFinalDecisionFile"}</td>
		<td width="80%" class="value">
			<input type="file" class="uploadField" name="finalDecisionFile" id="finalDecisionFile"/>
			<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.uploadRecordDecision"}"  class="button" />						
		</td>
	</tr>
{/if}
{if $proposalStatus != PROPOSAL_STATUS_COMPLETED}
<tr valign="top" id="finalDecision">
	<td class="label">{translate key="editor.article.finalDecision"}</td>
	<td class="value">
		{if !$submission->isSubmissionDue() && $proposalStatus == PROPOSAL_STATUS_REVIEWED || $proposalStatus == PROPOSAL_STATUS_EXEMPTED}
			{assign var="decision" value=$submission->getEditorDecisionKey()}
			{translate key=$decision}
			{if $submission->isSubmissionDue()}&nbsp;({translate key="submission.due"})&nbsp;{/if}
			{if $lastDecisionArray.decision == SUBMISSION_EDITOR_DECISION_ACCEPT}
				{$submission->getApprovalDate($submission->getLocale())|date_format:$dateFormatShort}
			{else}
				{$lastDecisionArray.dateDecided|date_format:$dateFormatShort}
			{/if}
		{else}
			{assign var="decisionAllowed" value="false"}
			{if $reviewAssignments}
				<!-- Change false to true for allowing decision only if all reviewers submitted a recommendation-->
				{assign var="decisionAllowed" value="false"}
				{foreach from=$reviewAssignments item=reviewAssignment}
					{if !$reviewAssignment->getRecommendation()}
						{assign var="decisionAllowed" value="false"}
					{/if}
				{/foreach}
			{/if}
			{if $decisionAllowed == "true"}
			<select id="decision" name="decision" size="1" class="selectMenu">
				{html_options_translate options=$editorDecisionOptions selected=0}
			</select>
			<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.uploadRecordDecision"}"  class="button" />
			{else}
				{translate key="common.none"}
			{/if}
		{/if}		
	</td>
</tr>
{/if}
</form>

{if ($proposalStatus == PROPOSAL_STATUS_RETURNED) || ($proposalStatus == PROPOSAL_STATUS_RESUBMITTED) || ($proposalStatus == PROPOSAL_STATUS_REVIEWED && $lastDecisionArray.decision == SUBMISSION_EDITOR_DECISION_RESUBMIT) }
	<tr valign="top" id="resubmitted">
		{assign var="articleLastModified" value=$submission->getLastModified()}
		{if $articleMoreRecent && $lastDecisionArray.resubmitCount!=null && $lastDecisionArray.resubmitCount!=0 }
			<td class="label"></td>
				{assign var="resubmitCount" value=$lastDecisionArray.resubmitCount}
			<td width="80%" class="value">
				{translate key="submissions.proposal.resubmittedMsg1"}{$resubmitMsg}{translate key="submissions.proposal.resubmittedMsg2"}{$articleLastModified|date_format:$dateFormatShort}
			</td>
		{/if}
	</tr>
	<tr valign="top">
	{if !$articleMoreRecent}
		<td title="Current status of the proposal." class="label" width="20%">[?] {translate key="editor.article.submissionStatus"}</td>
		<td width="80%" class="value">{translate key="editor.article.waitingForResubmission"}</td>
	{/if}
	</tr>
{/if}


{if $proposalStatus == PROPOSAL_STATUS_EXEMPTED}
	{assign var="localizedReasons" value=$submission->getLocalizedReasonsForExemption()}
	<form method="post" action="{url op="recordReasonsForExemption"}">
		<input type="hidden" name="articleId" value="{$submission->getId()}" />
		<input type="hidden" name="decision" value="{$lastDecisionArray.decision}" />	
	
		<tr valign="top">
			<td title="{translate key="editor.article.reasonsForExemptionInstruct"}" class="label">[?] {translate key="editor.article.reasonsForExemption"}</td>
			<td class="value"><!-- {*translate key="editor.article.exemption.instructions"*} --></td>
		</tr>
		{foreach from=$reasonsMap item=reasonLocale key=reasonVal}
			<tr valign="top">
				<td class="label" align="center">
					<input type="checkbox" name="exemptionReasons[]" id="reason{$reasonVal}" value={$reasonVal}	 {if $localizedReasons>0}disabled="true"{/if} {if $reasonsForExemption[$reasonVal] == 1}checked="checked"{/if}/>				
				</td>
				<td class="value">
					<label for="reason{$reasonVal}">{translate key=$reasonLocale}</label>
				</td>
			</tr>
		{/foreach}	
		{if !$localizedReasons}
		<tr>
			<td align="center"><input type="submit"  name="submit" value="{translate key="editor.article.record"}"  class="button" /></td>
		</tr>			
		{/if}
	</form>
{/if}

{if (($submission->getMostRecentDecision() == '6') || ($submission->getMostRecentDecision() == '1') || ($submission->getMostRecentDecision() == '3')) && $finalDecisionFileUploaded == false}
<form method="post" action="{url op="uploadDecisionFile" path=$submission->getId()}"  enctype="multipart/form-data">
	<tr valign="top">
		<td title="{translate key="editor.article.uploadFinalDecisionFileInstruct"}" class="label">[?] {translate key="editor.article.uploadFinalDecisionFile"}</td>
		<td class="value">		
			<input type="file" class="uploadField" name="finalDecisionFile" id="finalDecisionFile"/>
			<input type="submit" class="button" value="{translate key="common.upload"}" />
		</td>
	</tr>
</form>
{/if}

<tr valign="top">
	<td title="{translate key="submission.notifyAuthorInstruct"}" class="label">[?] {translate key="submission.notifyAuthor"}</td>
	<td class="value">
		{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}
<!-- 
		{*******************************
		 *
		 * Edited by aglet
		 * Last Update: 6/5/2011
		 *
		 The last decision was a decline; notify the user that sending this message will archive the submission. }
		{translate|escape:"quotes"|assign:"confirmString" key="editor.submissionReview.emailWillArchive"}
		{icon name="mail" url=$notifyAuthorUrl onclick="return confirm('$confirmString')" 
		*
		*******************************}
 -->
		{icon name="mail" url=$notifyAuthorUrl}
	
		&nbsp;&nbsp;&nbsp;&nbsp;
		{translate key="submission.editorAuthorRecord"}
		{if $submission->getMostRecentEditorDecisionComment()}
			{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{translate key="editor.article.decisionLastComment"}: {$comment->getDatePosted()|date_format:$dateFormatShort}
		{else}
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
		{/if}
	</td>
</tr>
</table>

<form method="post" action="{url op="editorReview"}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$submission->getId()}" />
{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}

{assign var="authorRevisionExists" value=false}
{foreach from=$authorFiles item=authorFile}
	{assign var="authorRevisionExists" value=true}
{/foreach}

{assign var="editorRevisionExists" value=false}
{foreach from=$editorFiles item=editorFile}
	{assign var="editorRevisionExists" value=true}
{/foreach}
{if $reviewFile}
	{assign var="reviewVersionExists" value=1}
{/if}
</table>

</form>
</div>

