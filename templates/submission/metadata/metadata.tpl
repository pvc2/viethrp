{**
 * metadata.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission metadata table. Non-form implementation.
 *}
<div id="metadata">
{*<h3>{translate key="submission.metadata"}</h3>*}

{if $canEditMetadata}
	<p><a href="{url op="viewMetadata" path=$submission->getId()}" class="action">{translate key="submission.editMetadata"}</a></p>
	{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalEditItems"}
{/if}

<div id="authors">
<h4>{*translate key="article.authors"*}RTO and Primary Investigators</h4>
	
<table width="100%" class="data">
	{foreach name=authors from=$submission->getAuthors() item=author}
	<tr valign="top">
		<td width="20%" class="label">{*translate key="user.name"*}{if $author->getPrimaryContact()}RTO{else}Primary Investigator{/if}</td>
		<td width="80%" class="value">
			{assign var=emailString value=$author->getFullName()|concat:" <":$author->getEmail():">"}
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
			{$author->getFullName()|escape} {icon name="mail" url=$url}
		</td>
	</tr>
        {*
	{if $author->getUrl()}
		<tr valign="top">
			<td class="label">{translate key="user.url"}</td>
			<td class="value"><a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a></td>
		</tr>
	{/if}
        *}
        {*
	<tr valign="top">
		<td class="label">{translate key="user.affiliation"}</td>
		<td class="value">{$author->getLocalizedAffiliation()|escape|nl2br|default:"&mdash;"}</td>
	</tr>
        *}
        {*
	<tr valign="top">
		<td class="label">{translate key="common.country"}</td>
		<td class="value">{$author->getCountryLocalized()|escape|default:"&mdash;"}</td>
	</tr>
        *}
{*
	{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
		<tr valign="top">
			<td class="label">
				{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
				{translate key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}
			</td>
			<td class="value">{$author->getLocalizedCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
		</tr>
	{/if}
*}
{*
	<tr valign="top">
		<td class="label">{translate key="user.biography"}</td>
		<td class="value">{$author->getLocalizedBiography()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>
*}
        {*
	{if $author->getPrimaryContact()}
		<tr valign="top">
			<td colspan="2" class="label">{translate key="author.submit.selectPrincipalContact"}</td>
		</tr>
	{/if}
        *}
	{if !$smarty.foreach.authors.last}
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
	{/if}
	{/foreach}
</table>
</div>

<div id="titleAndAbstract">
<h4>Proposal Details</h4>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="proposal.title"}</td>
		<td width="80%" class="value">{$submission->getLocalizedTitle()|strip_unsafe_html|default:"&mdash;"}</td>
	</tr>
        
	<tr valign="top">
		<td class="label">{translate key="proposal.abstract"}</td>
		<td class="value">{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.objectives"}</td>
		<td class="value">{$submission->getLocalizedObjectives()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.keywords"}</td>
		<td class="value">{$submission->getLocalizedKeywords()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.startDate"}</td>
		<td class="value">{$submission->getLocalizedStartDate()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.endDate"}</td>
		<td class="value">{$submission->getLocalizedEndDate()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.fundsRequired"}</td>
		<td class="value">{$submission->getLocalizedFundsRequired()|strip_unsafe_html|nl2br|replace:',':''|number_format:2:".":","|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.proposalCountry"}</td>
		<td class="value">{$submission->getLocalizedProposalCountryText()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.technicalUnit"}</td>
		<td class="value">{$submission->getLocalizedTechnicalUnitText()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.proposalType"}</td>
		<td class="value">{$submission->getLocalizedProposalTypeText()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.submittedAsPi"}</td>
		<td class="value">{$submission->getLocalizedSubmittedAsPi()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.conflictOfInterest"}</td>
		<td class="value">{$submission->getLocalizedConflictOfInterest()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>

        <tr valign="top">
		<td class="label">{translate key="proposal.reviewedByOtherErc"}</td>
		<td class="value">{$submission->getLocalizedReviewedByOtherErc()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>
        {*
        {if $submission->getSubmissionStatus()==PROPOSAL_STATUS_SUBMITTED}
            <tr>
                <td colspan="2"><a href=</td>
            </tr>
        {/if}
        *}
</table>
</div>

<!-- by AIM, 10.13.2011
{*
<div id="indexing">
<h4>{translate key="submission.indexing"}</h4>
	
<table width="100%" class="data">
	{if $currentJournal->getSetting('metaDiscipline')}
		<tr valign="top">
			<td width="20%" class="label">{translate key="article.discipline"}</td>
			<td width="80%" class="value">{$submission->getLocalizedDiscipline()|escape|default:"&mdash;"}</td>
		</tr>
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
	{/if}
	{if $currentJournal->getSetting('metaSubjectClass')}
		<tr valign="top">
			<td width="20%" class="label">{translate key="article.subjectClassification"}</td>
			<td width="80%" class="value">{$submission->getLocalizedSubjectClass()|escape|default:"&mdash;"}</td>
		</tr>
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
	{/if}
	{if $currentJournal->getSetting('metaSubject')}
		<tr valign="top">
			<td width="20%" class="label">{translate key="article.subject"}</td>
			<td width="80%" class="value">{$submission->getLocalizedSubject()|escape|default:"&mdash;"}</td>
		</tr>
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
	{/if}
	{if $currentJournal->getSetting('metaCoverage')}
		<tr valign="top">
			<td width="20%" class="label">{translate key="article.coverageGeo"}</td>
			<td width="80%" class="value">{$submission->getLocalizedCoverageGeo()|escape|default:"&mdash;"}</td>
		</tr>
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
		<tr valign="top">
			<td class="label">{translate key="article.coverageChron"}</td>
			<td class="value">{$submission->getLocalizedCoverageChron()|escape|default:"&mdash;"}</td>
		</tr>
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
		<tr valign="top">
			<td class="label">{translate key="article.coverageSample"}</td>
			<td class="value">{$submission->getLocalizedCoverageSample()|escape|default:"&mdash;"}</td>
		</tr>
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
	{/if}
	{if $currentJournal->getSetting('metaType')}
		<tr valign="top">
			<td width="20%" class="label">{translate key="article.type"}</td>
			<td width="80%" class="value">{$submission->getLocalizedType()|escape|default:"&mdash;"}</td>
		</tr>
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
	{/if}
	<tr valign="top">
		<td width="20%" class="label">{translate key="article.language"}</td>
		<td width="80%" class="value">{$submission->getLanguage()|escape|default:"&mdash;"}</td>
	</tr>
</table>
</div>

<div id="supportingAgencies">
<h4>{translate key="submission.supportingAgencies"}</h4>
	
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="submission.agencies"}</td>
		<td width="80%" class="value">{$submission->getLocalizedSponsor()|escape|default:"&mdash;"}</td>
	</tr>
</table>
</div>

{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalMetadata"}

{if $currentJournal->getSetting('metaCitations')}
	<div id="citations">
	<h4>{translate key="submission.citations"}</h4>

	<table width="100%" class="data">
		<tr valign="top">
			<td width="20%" class="label">{translate key="submission.citations"}</td>
			<td width="80%" class="value">{$submission->getCitations()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
		</tr>
	</table>
	</div>
{/if}

</div><!-- metadata -->

*}
-->

