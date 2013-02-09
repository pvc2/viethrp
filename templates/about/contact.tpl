{**
 * contact.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Vietnam Health Research Portal / Contact.
 *
 * $Id$
 *}

{strip}
	{assign var="pageTitle" value="about.journalContact"}
	{include file="common/header.tpl"}
{/strip}

<div id="contact">

{if count($ercChair) > 0}
<h4>{translate key="user.role.chair"}</h4>
	<div id="ercChair">
	<ol class="contact">
		{foreach from=$ercChair item=ercChair} 
			<strong>{$ercChair->getFullName()|escape}</strong> 
			{if $ercChair->getLocalizedAffiliation()}<br/>{$ercChair->getLocalizedAffiliation()|escape}{/if}
			<br/> &#187; {translate key="about.contact.email"} {assign var=emailString value=$ercChair->getFullName()|concat:" <":$ercChair->getEmail():">"}{url|assign:"url" page="user" op="email" to=$emailString|to_array}{icon name="mail" url=$url}<br/><br/>
		{/foreach}
	</ol>
	</div>
{/if}

						

{if count($ercViceChair) > 0}
<h4>{translate key="user.role.viceChair"}</h4>
	<div id="ercViceChair">
	<ol class="contact">
		{foreach from=$ercViceChair item=ercViceChair} 
			<strong>{$ercViceChair->getFullName()|escape}</strong> 
			{if $ercViceChair->getLocalizedAffiliation()}<br/>{$ercViceChair->getLocalizedAffiliation()|escape}{/if}
			<br/> &#187; {translate key="about.contact.email"} {assign var=emailString value=$ercViceChair->getFullName()|concat:" <":$ercViceChair->getEmail():">"}{url|assign:"url" page="user" op="email" to=$emailString|to_array}{icon name="mail" url=$url}<br/><br/>
		{/foreach}
	</ol>
	</div>
{/if}


{if count($secretary) > 0}
{if count($secretary) == 1}
<h4>Secretary</h4>
{else}
<h4>{translate key="user.role.editor"}</h4>
{/if}
	<div id="secretary">
	<ol class="contact">
		{foreach from=$secretary item=secretary} 
			<strong>{$secretary->getFullName()|escape}</strong> 
			{if $secretary->getLocalizedAffiliation()}<br/>{$secretary->getLocalizedAffiliation()|escape}{/if}
			<br/> &#187; {translate key="about.contact.email"} {assign var=emailString value=$secretary->getFullName()|concat:" <":$secretary->getEmail():">"}{url|assign:"url" page="user" op="email" to=$emailString|to_array}{icon name="mail" url=$url}<br/><br/>
		{/foreach}
	</ol>
	</div>
{/if}

{if count($ercMembers) > 0}
<h4>{translate key="user.role.reviewers"}</h4>
	<div id="ercMembers">
	<ol class="contact">
		{foreach from=$ercMembers item=ercMembers} 
			<strong>{$ercMembers->getFullName()|escape}</strong> 
			{if $ercMembers->getLocalizedAffiliation()}<br/>{$ercMembers->getLocalizedAffiliation()|escape}{/if}
			<br/> &#187; {translate key="about.contact.email"} {assign var=emailString value=$ercMembers->getFullName()|concat:" <":$ercMembers->getEmail():">"}{url|assign:"url" page="user" op="email" to=$emailString|to_array}{icon name="mail" url=$url}<br/><br/>
		{/foreach}
	</ol>
	</div>
{/if}
</div>

{include file="common/footer.tpl"}