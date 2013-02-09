{**
 * authorFees.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display of author fees and payment information
 *
 *}
<div id="authorFees">
{*<h3>{translate key="manager.payment.authorFees"}</h3>*}
<table width="100%" class="data">
{if $currentJournal->getSetting('submissionFeeEnabled')}
	<tr>
		<td width="20%">{*$currentJournal->getLocalizedSetting('submissionFeeName')|escape*}<h3>{translate key="manager.payment.authorFees"}</h3></td>
		<td width="80%">
	{if $submissionPayment}
		<b>{translate key="manager.payment.paymentSolved"}</b><br/>{translate key="manager.payment.paymentMethod"}:&nbsp;&nbsp;
		{if ($submissionPayment->getPayMethodPluginName()) == 'ManualPayment'}{translate key="manager.payment.paymentReceived"}<br/>{translate key="manager.payment.paymentDate"}: {$submissionPayment->getTimestamp()|date_format:$datetimeFormatLong}
		{elseif ($submissionPayment->getPayMethodPluginName()) == 'Waiver'}{translate key="manager.payment.paymentWaived"}<br/>{translate key="manager.payment.paymentDate"}: {$submissionPayment->getTimestamp()|date_format:$datetimeFormatLong}
		{/if}
	{elseif $submission->getLocalizedStudentInitiatedResearch() == 'Yes'}
		<b>{translate key="manager.payment.paymentSolved"}</b><br/>{translate key="manager.payment.paymentMethod"}:&nbsp;&nbsp;{translate key="manager.payment.paymentExempted"}
	{else}
		{translate key="manager.payment.paymentConfirm"}:<br/>
		<input type="button" value="Payment Received" class="button" onclick="confirmAction('{url op="waiveSubmissionFee" path=$submission->getArticleId() markAsPaid=true}', '{translate key="manager.payment.paymentReceivedConfirm"}')" />
		&nbsp;or&nbsp;<input type="button" value="Waive Payment" class="button" onclick="confirmAction('{url op="waiveSubmissionFee" path=$submission->getArticleId()}', '{translate key="manager.payment.paymentWaivedConfirm"}')" />
		{*<a class="action" href="{url op="waiveSubmissionFee" path=$submission->getArticleId() markAsPaid=true}">{translate key="payment.paymentReceived"}</a>&nbsp;|&nbsp;<a class="action" href="{url op="waiveSubmissionFee" path=$submission->getArticleId()}">{translate key="payment.waive"}</a>*}
	{/if}
		</td>
	</tr>
{/if}
{if $currentJournal->getSetting('fastTrackFeeEnabled')}
	<tr>
		<td width="20%">{$currentJournal->getLocalizedSetting('fastTrackFeeName')|escape}</td>
		<td width="80%"> 
	{if $fastTrackPayment}
		{translate key="payment.paid"} {$fastTrackPayment->getTimestamp()|date_format:$datetimeFormatLong}
	{else}
		<a class="action" href="{url op="waiveFastTrackFee" path=$submission->getArticleId() markAsPaid=true}">{translate key="payment.paymentReceived"}</a>&nbsp;|&nbsp;<a class="action" href="{url op="waiveFastTrackFee" path=$submission->getArticleId()}">{translate key="payment.waive"}</a>		
	{/if}
		</td>
	</tr>	
{/if}
{if $currentJournal->getSetting('publicationFeeEnabled')}
	<tr>
		<td width="20%">{$currentJournal->getLocalizedSetting('publicationFeeName')|escape}</td>
		<td width="80%">
	{if $publicationPayment}
		{translate key="payment.paid"} {$publicationPayment->getTimestamp()|date_format:$datetimeFormatLong}
	{else}
		<a class="action" href="{url op="waivePublicationFee" path=$submission->getArticleId() markAsPaid=true}">{translate key="payment.paymentReceived"}</a>&nbsp;|&nbsp;<a class="action" href="{url op="waivePublicationFee" path=$submission->getArticleId()}">{translate key="payment.waive"}</a>		
	{/if}
		</td>
	</tr>
{/if}
</table>
</div>
