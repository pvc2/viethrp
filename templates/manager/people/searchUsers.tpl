{**
 * searchUsers.tpl
 *
 * Search form for enrolled users.
 *
 * $Id$
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="manager.people.roleEnrollment" role=$roleName|translate}
{include file="common/header.tpl"}
{/strip}

<form name="disableUser" method="post" action="{url op="disableUser"}">
	<input type="hidden" name="reason" value=""/>
	<input type="hidden" name="userId" value=""/>
</form>



<script type="text/javascript">
<!--
function confirmAndPrompt(userId) {ldelim}
	var reason = prompt('{translate|escape:"javascript" key="manager.people.confirmDisable"}');
	if (reason == null) return;

	document.disableUser.reason.value = reason;
	document.disableUser.userId.value = userId;

	document.disableUser.submit();
{rdelim}

function toggleChecked() {ldelim}
	var elements = document.enroll.elements;
	for (var i=0; i < elements.length; i++) {ldelim}
		if (elements[i].name == 'users[]') {ldelim}
			elements[i].checked = !elements[i].checked;
		{rdelim}
	{rdelim}
{rdelim}
// -->

function checkSelected(){ldelim}
	var elements = document.enroll.elements;
	var countSelected = 0;
	for (var i=0; i < elements.length; i++) {ldelim}
		if (elements[i].name == 'users[]') {ldelim}
			if (elements[i].checked) {ldelim}
				countSelected++;
			{rdelim}
		{rdelim}
	{rdelim}
	return countSelected;
{rdelim}

<!-- Added by EL on April 25, 2012: Management of the ERC Status -->

$(document).ready(
    function() {ldelim}
    	showOrHideEthicsCommitteeField();
        $('#roleId').change(showOrHideEthicsCommitteeField);
        showOrHideErcMemberStatusField();
        $('#ethicsCommittee').change(showOrHideErcMemberStatusField);
        showOrHideButtons();
        $('#ercMemberStatus').change(showOrHideButtons);
	{rdelim}
);

function showOrHideEthicsCommitteeField() {ldelim}
    var isErcMemberSelected = false;
    
    <!-- This variable and its use is only to be sure that a role is selected-->
    var isSomethingSelected = false;
    
    var isTechReviewerSelected = false;
    
    if ($('#roleId').val() != null) {ldelim}
        $.each(
            $('#roleId').val(), function(key, value){ldelim}
                if(value == 0x00001000) {ldelim}
                    isErcMemberSelected = true;
                {rdelim}
                if(value == 0x00000010 || value == 0x00010000 || value == 0x00000100){ldelim}
                	isSomethingSelected = true;
                {rdelim}
                else if (value=="TechReviewer"){ldelim}
                	isTechReviewerSelected = true;
                {rdelim}
            {rdelim}
        );
    {rdelim}
    
    $('#crecChairErrorMessage').hide();
    $('#crecViceChairErrorMessage').hide();
    $('#crecSecretaryErrorMessage').hide();
    $('#crecSecretaryTooManySelected').hide();
    $('#placesAvailableForCrecSecretary').hide();
    $('#crecMembersErrorMessage').hide();
    $('#crecMembersTooManySelected').hide();
    $('#placesAvailableForCrecMember').hide();

    $('#hsphChairErrorMessage').hide();
    $('#hsphViceChairErrorMessage').hide();    
    $('#hsphSecretaryErrorMessage').hide();
    $('#hsphSecretaryTooManySelected').hide();
    $('#placesAvailableForHsphSecretary').hide();
    $('#hsphMembersErrorMessage').hide();
    $('#hsphMembersTooManySelected').hide();
    $('#placesAvailableForHsphMember').hide();
    
    if(isErcMemberSelected) {ldelim}
        $('#ethicsCommitteeField').show();
        $('#noEthicsCommitteeSelected').show();
        $('#nothingSelected').hide();
        $('#submit').hide();
    {rdelim} else if(isSomethingSelected) {ldelim}
        $('#submit').show();
        $('#noEthicsCommitteeSelected').hide();
        $('#nothingSelected').hide();
        $('#noMemberStatusSelected').hide();
        $('#ethicsCommitteeField').hide();
        $('#ercMemberStatusField').hide();
        $('#ethicsCommittee').val("NA");
        $('#ercMemberStatus').val("NA");
    {rdelim} else if(isTechReviewerSelected) {ldelim}
        $('#submit').show();
        $('#noEthicsCommitteeSelected').hide();
        $('#nothingSelected').hide();
        $('#noMemberStatusSelected').hide();
        $('#ethicsCommitteeField').hide();
        $('#ercMemberStatusField').hide();
        $('#ethicsCommittee').val("NA");
        $('#ercMemberStatus').val("NA");
    {rdelim} else {ldelim}
    	$('#nothingSelected').show();
    	$('#noEthicsCommitteeSelected').hide();
    	$('#noMemberStatusSelected').hide();
    	$('#ercMemberStatusField').hide();
    	$('#ethicsCommitteeField').hide();
        $('#ethicsCommittee').val("NA");
        $('#ercMemberStatus').val("NA");
    {rdelim}
{rdelim}

function showOrHideErcMemberStatusField() {ldelim}
    
    var isEthicsCommitteeSelected = false;
    
    if ($('#ethicsCommittee').val() != null) {ldelim}
        $.each(
            $('#ethicsCommittee').val(), function(key, value){ldelim}
                if(value == "HSPH" || value == "CREC"){ldelim}
                	isEthicsCommitteeSelected = true;
                {rdelim}
            {rdelim}
        );
    {rdelim}
    
    $('#crecChairErrorMessage').hide();
    $('#crecViceChairErrorMessage').hide();
    $('#crecSecretaryErrorMessage').hide();
    $('#crecSecretaryTooManySelected').hide();
    $('#placesAvailableForCrecSecretary').hide();
    $('#crecMembersErrorMessage').hide();
    $('#crecMembersTooManySelected').hide();
    $('#placesAvailableForCrecMember').hide();

    $('#hsphChairErrorMessage').hide();
    $('#hsphViceChairErrorMessage').hide();    
    $('#hsphSecretaryErrorMessage').hide();
    $('#hsphSecretaryTooManySelected').hide();
    $('#placesAvailableForHsphSecretary').hide();
    $('#hsphMembersErrorMessage').hide();
    $('#hsphMembersTooManySelected').hide();
    $('#placesAvailableForHsphMember').hide();
    
    if (isEthicsCommitteeSelected) {ldelim}
        $('#noEthicsCommitteeSelected').hide();
        $('#ercMemberStatusField').show();
        $('#noMemberStatusSelected').show();
        $('#ercMemberStatus').val("NA");
        $('#submit').hide();
    {rdelim} else {ldelim}
    	$('#ercMemberStatusField').hide();
        $('#ercMemberStatus').val("NA");
    {rdelim}
{rdelim}

function showOrHideButtons() {ldelim}

	var isCrecSelected = false;
	var isHsphSelected = false;
	var isChairSelected = false;
	var isViceChairSelected = false;
    var isSecretarySelected = false;  
    var isMemberSelected = false;
    
    var checkCheckbox = checkSelected();
	
    if ($('#ethicsCommittee').val() != null) {ldelim}
        $.each(
            $('#ethicsCommittee').val(), function(key, value){ldelim}
                if(value == "CREC"){ldelim}
                	isCrecSelected = true;
                {rdelim}
                else if(value == "HSPH"){ldelim}
                	isHsphSelected =true;
                {rdelim}
            {rdelim}
        );
    {rdelim}
    
    if ($('#ercMemberStatus').val() != null) {ldelim}
        $.each(
            $('#ercMemberStatus').val(), function(key, value){ldelim}
                if(value == "ERC, Chair") {ldelim}
                    isChairSelected = true;                    
                {rdelim}
                else if(value == "ERC, Vice-Chair") {ldelim}
                    isViceChairSelected = true;                   
                {rdelim}
                else if(value == "ERC, Secretary") {ldelim}
                    isSecretarySelected = true;                   
                {rdelim}
                else if(value == "ERC, Member") {ldelim}
                    isMemberSelected = true;                   
                {rdelim}
            {rdelim}
        );
    {rdelim}
    
    $('#crecChairErrorMessage').hide();
    $('#crecViceChairErrorMessage').hide();
    $('#crecSecretaryErrorMessage').hide();
    $('#crecSecretaryTooManySelected').hide();
    $('#placesAvailableForCrecSecretary').hide();
    $('#crecMembersErrorMessage').hide();
    $('#crecMembersTooManySelected').hide();
    $('#placesAvailableForCrecMember').hide();

    $('#hsphChairErrorMessage').hide();
    $('#hsphViceChairErrorMessage').hide();    
    $('#hsphSecretaryErrorMessage').hide();
    $('#hsphSecretaryTooManySelected').hide();
    $('#placesAvailableForHsphSecretary').hide();
    $('#hsphMembersErrorMessage').hide();
    $('#hsphMembersTooManySelected').hide();
    $('#placesAvailableForHsphMember').hide();
    
     $('#tooManySelected').hide();
    
    if (isCrecSelected) {ldelim}
        if(isChairSelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$isCrecChair}=='1'){ldelim}
        		$('#submit').hide();
        		$('#crecChairErrorMessage').show();
        	{rdelim}
       		else if (checkCheckbox>'1') {ldelim}
        		$('#submit').hide();
        		$('#tooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#submit').show();
        	{rdelim}        
    	{rdelim}
        else if(isViceChairSelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$isCrecViceChair}=='1'){ldelim}
        		$('#submit').hide();
        		$('#crecViceChairErrorMessage').show();
        	{rdelim}
       		else if (checkCheckbox>'1') {ldelim}
        		$('#submit').hide();
        		$('#tooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#submit').show();
        	{rdelim}        
    	{rdelim}
        else if(isSecretarySelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$areCrecSecretary}=='1'){ldelim}
        		$('#submit').hide();
        		$('#crecSecretaryErrorMessage').show();
        	{rdelim}
       		else if (checkCheckbox>{$freeCrecSecretaryPlaces}) {ldelim}
        		$('#submit').hide();
        		$('#crecSecretaryTooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#placesAvailableForCrecSecretary').show();
        		$('#submit').show();
        	{rdelim}        
    	{rdelim}
    	else if(isMemberSelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$areCrecMembers}=='1'){ldelim}
        		$('#submit').hide();
        		$('#crecMembersErrorMessage').show();
        	{rdelim}
        	else if (checkCheckbox>{$freeCrecMemberPlaces}) {ldelim}
        		$('#submit').hide();
        		$('#crecMembersTooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#placesAvailableForCrecMember').show();
        		$('#submit').show();
        	{rdelim} 
    	{rdelim}
    {rdelim}
    else if (isHsphSelected) {ldelim}
        if(isChairSelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$isHsphChair}=='1'){ldelim}
        		$('#submit').hide();
        		$('#hsphChairErrorMessage').show();
        	{rdelim}
       		else if (checkCheckbox>'1') {ldelim}
        		$('#submit').hide();
        		$('#tooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#submit').show();
        	{rdelim}        
    	{rdelim}
        else if(isViceChairSelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$isHsphViceChair}=='1'){ldelim}
        		$('#submit').hide();
        		$('#hsphViceChairErrorMessage').show();
        	{rdelim}
       		else if (checkCheckbox>'1') {ldelim}
        		$('#submit').hide();
        		$('#tooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#submit').show();
        	{rdelim}        
    	{rdelim}
        else if(isSecretarySelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$areHsphSecretary}=='1'){ldelim}
        		$('#submit').hide();
        		$('#hsphSecretaryErrorMessage').show();
        	{rdelim}
       		else if (checkCheckbox>{$freeHsphSecretaryPlaces}) {ldelim}
        		$('#submit').hide();
        		$('#hsphSecretaryTooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#placesAvailableForHsphSecretary').show();
        		$('#submit').show();
        	{rdelim}        
    	{rdelim}
    	else if(isMemberSelected) {ldelim}
    		$('#noMemberStatusSelected').hide();
    		if({$areHsphMembers}=='1'){ldelim}
        		$('#submit').hide();
        		$('#hsphMembersErrorMessage').show();
        	{rdelim}
        	else if (checkCheckbox>{$freeHsphMemberPlaces}) {ldelim}
        		$('#submit').hide();
        		$('#hsphMembersTooManySelected').show();
        	{rdelim}        
        	else {ldelim}
        		$('#placesAvailableForHsphMember').show();
        		$('#submit').show();
        	{rdelim} 
    	{rdelim}
    {rdelim}
{rdelim}

<!-- End of management of the ERC Status -->
</script>

{if not $omitSearch}
	<form method="post" name="submit" action="{url op="enrollSearch"}">
	<input type="hidden" name="roleId" value="{$roleId|escape}"/>
		<select name="searchField" size="1" class="selectMenu">
			{html_options_translate options=$fieldOptions selected=$searchField}
		</select>
		<select name="searchMatch" size="1" class="selectMenu">
			<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
			<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
			<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
		</select>
		<input type="text" size="15" name="search" class="textField" value="{$search|escape}" />&nbsp;<input type="submit" value="{translate key="common.search"}" class="button" />
	</form>

	<p>{foreach from=$alphaList item=letter}<a href="{url op="enrollSearch" searchInitial=$letter roleId=$roleId}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="enrollSearch" roleId=$roleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>
{/if}

<form name="enroll" onsubmit="return enrollUser(0)" action="{if $roleId}{url op="enroll" path=$roleId}{else}{url op="enroll"}{/if}" method="post">
{if !$roleId}
    <table width="100%" class="data">
	<div id=enrollUserAs>
	<tr valign="top" id="roleIdField">
    	<td width="20%" class="label"><strong>Enroll user as :</strong></td>
    	<td width="80%" class="value">
			<select name="roleId" multiple="multiple" size="5" id="roleId" class="selectMenu">
				<option value="{$smarty.const.ROLE_ID_JOURNAL_MANAGER}">{translate key="user.role.manager"}</option>
				<option value="{$smarty.const.ROLE_ID_REVIEWER}">Ethics Committee Member</option>
				<option value="{$smarty.const.ROLE_ID_AUTHOR}">{translate key="user.role.author"}</option>
				<option value="{$smarty.const.ROLE_ID_EDITOR}">{translate key="user.role.coordinator"}</option>
				<option value="TechReviewer">{translate key="user.role.technicalReviewer"}</option>
					<!-- Commented out - el - 19 April 2012 -->
	        		{*	<option value="{$smarty.const.ROLE_ID_SECTION_EDITOR}">{translate key="user.role.sectionEditor"}</option> 
					{if $roleSettings.useLayoutEditors}
					<option value="{$smarty.const.ROLE_ID_LAYOUT_EDITOR}">{translate key="user.role.layoutEditor"}</option>
					{/if}
					{if $roleSettings.useCopyeditors}
					<option value="{$smarty.const.ROLE_ID_COPYEDITOR}">{translate key="user.role.copyeditor"}</option>
					{/if}
					{if $roleSettings.useProofreaders}
					<option value="{$smarty.const.ROLE_ID_PROOFREADER}">{translate key="user.role.proofreader"}</option>
					{/if}*}
					<!--	<option value="{$smarty.const.ROLE_ID_READER}">{translate key="user.role.reader"}</option> Edited by MSB, Nov17, 2011-->
					<!--	<option value="{$smarty.const.ROLE_ID_SUBSCRIPTION_MANAGER}">{translate key="user.role.subscriptionManager"}</option> Edited by MSB, Nov17, 2011-->
			</select>
		</td>
	</tr>
	
	<tr valign="top" id="ethicsCommitteeField"  style="display: none;">
		<td width="20%" class="label"><strong>Ethics Committee :</strong></td>
		<td width="80%" class="value">
			<select name="ethicsCommittee" multiple="multiple" size="1" id="ethicsCommittee" class="selectMenu">
				<option value="HSPH">HSPH</option>
			</select>
		</td>
	</tr>
	
	<!-- Added by EL on April 25, 2012: Management of the ERC Status -->
    <tr valign="top" id="ercMemberStatusField" style="display: none;">
        <td width="20%" class="label"><strong>Status :</strong></td>
        <td width="80%" class="value">
			<select name="ercMemberStatus" multiple="multiple" size="4" id="ercMemberStatus" class="selectMenu">
				<option value="ERC, Chair">Chair</option>
				<option value="ERC, Vice-Chair">Vice-Chair</option>
				<option value="ERC, Secretary">Secretary</option>
				<!--<option value="ERC, Secretary Administrative Assistant">Secretary Administrative Assistant</option>-->
				<option value="ERC, Member">Member</option>
				<!--<option value="ERC, External Member">External Member</option>-->
			</select>
		</td>
	</tr>
	<!-- End of management of the ERC Status -->
	
	</table>
	<script type="text/javascript">
	<!--
	function enrollUser(userId) {ldelim}
		var fakeUrl = '{url op="enroll" path="ROLE_ID" userId="USER_ID"}';
		if (document.enroll.roleId.options[document.enroll.roleId.selectedIndex].value == '') {ldelim}
			alert("{translate|escape:"javascript" key="manager.people.mustChooseRole"}");
			return false;
		{rdelim}
		if (userId != 0){ldelim}
		fakeUrl = fakeUrl.replace('ROLE_ID', document.enroll.roleId.options[document.enroll.roleId.selectedIndex].value);
		fakeUrl = fakeUrl.replace('USER_ID', userId);
		location.href = fakeUrl;
	{rdelim}
	{rdelim}
	// -->
	</div>
	</script>
{/if}

<!-- Added by EL on April 25, 2012: Management of the ERC Status -->
<p id="nothingSelected" style="display: none;"><font color=#FF0000>
Please select a type of enrollement<br/>
</font>
</p>
<p id="noEthicsCommitteeSelected" style="display: none;"><font color=#FF0000>
Please select an Ethics Committee<br/>
</font>
</p>
<p id="noMemberStatusSelected" style="display: none;"><font color=#FF0000>
Please select an Ethics Committee Status<br/>
</font>
</p>
<p id="crecChairErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
A Chair is already set into the CREC:<br />
</font>
{foreach from=$crecChair item=crecChair}
{$crecChair->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll him/her before enrolling someone else.
</font></p>
<p id="crecViceChairErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
A Vice-Chair is already set into the CREC:<br />
</font>
{foreach from=$crecViceChair item=crecViceChair}
{$crecViceChair->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll him/her before enrolling someone else.
</font></p>
<p id="hsphChairErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
A Chair is already set into the HSPH:<br />
</font>
{foreach from=$hsphChair item=hsphChair}
{$hsphChair->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll him/her before enrolling someone else.
</font></p>
<p id="hsphViceChairErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
A Vice-Chair is already set into the HSPH:<br />
</font>
{foreach from=$hsphViceChair item=hsphViceChair}
{$hsphViceChair->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll him/her before enrolling someone else.
</font></p>
<p id="crecSecretaryErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many Secretaries are set in the CREC:<br />
</font>
{foreach from=$crecSecretary item=crecSecretary}
{$crecSecretary->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll at least one before enrolling someone else.
</font></p>
<p id="hsphSecretaryErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many Secretaries are set in the HSPH:<br />
</font>
{foreach from=$hsphSecretary item=hsphSecretary}
{$hsphSecretary->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll at least one before enrolling someone else.
</font></p>
<p id="crecMembersErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many ERC members are set in the CREC:<br />
</font>
{foreach from=$crecMembers item=crecMembers}
{$crecMembers->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll at least one before enrolling someone else.
</font></p>
<p id="hsphMembersErrorMessage" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many ERC members are set in the HSPH:<br />
</font>
{foreach from=$hsphMembers item=hsphMembers}
{$hsphMembers->getFullName()|escape}<br />
{/foreach}
<font color=#FF0000>
Please unenroll at least one before enrolling someone else.
</font></p>
<p id="tooManySelected" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many users selected.<br />
Only 1 place available.
</font></p>
<p id="crecSecretaryTooManySelected" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many secretaries selected for the CRC.<br />
Only {$freeCrecSecretaryPlaces} place(s) available.
</font></p>
<p id="hsphSecretaryTooManySelected" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many secretaries selected for the HSPH.<br />
Only {$freeHsphSecretaryPlaces} place(s) available.
</font></p>
<p id="crecMembersTooManySelected" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many members selected for the CREC.<br />
Only {$freeCrecMemberPlaces} place(s) available.
</font></p>
<p id="hsphMembersTooManySelected" style="display: none;"><font color=#FF0000>
<strong>ATTENTION :</strong><br />
Too many members selected for the HSPH.<br />
Only {$freeHsphMemberPlaces} place(s) available.
</font></p>
<p id="placesAvailableForCrecMember" style="display: none;"><font color=#1e7fb8>
CREC member: {$freeCrecMemberPlaces} place(s) available.<br />
</font></p>
<p id="placesAvailableForHsphMember" style="display: none;"><font color=#1e7fb8>
HSPH Member: {$freeHsphMemberPlaces} place(s) available.<br />
</font></p>
<p id="placesAvailableForCrecSecretary" style="display: none;"><font color=#1e7fb8>
CREC Secretary: {$freeCrecSecretaryPlaces} place(s) available.<br />
</font></p>
<p id="placesAvailableForHsphSecretary" style="display: none;"><font color=#1e7fb8>
HSPH Secretary: {$freeHsphSecretaryPlaces} place(s) available.<br />
</font></p>
<!-- End of management of the ERC Status -->


<div id="users">
<table width="100%" class="listing">
<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
<tr class="heading" valign="bottom">
	<td width="5%">&nbsp;</td>
	<td width="10%">{sort_heading key="user.username" sort="username"}</td>
	<td width="10%">{sort_heading key="user.name" sort="name"}</td>
	<td width="35%">Function(s)</td>
	<td width="10%">{sort_heading key="user.email" sort="email"}</td>
	<td width="10%" align="right">{translate key="common.disableEnable"}</td>
</tr>
<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
{iterate from=users item=user}
{assign var="userid" value=$user->getId()}
{assign var="stats" value=$statistics[$userid]}
<tr valign="top">
	<td><input type="checkbox" name="users[]" value="{$user->getId()}" onclick="showOrHideButtons()" /></td>
	<td><a class="action" href="{url op="userProfile" path=$userid}">{$user->getUsername()|escape}</a></td>
	<td>{$user->getFullName()|escape}</td>
	<td>{$user->getFunctions()|escape}</td>
	<td class="nowrap">
		{assign var=emailString value=$user->getFullName()|concat:" <":$user->getEmail():">"}
		{url|assign:"url" page="user" op="email" to=$emailString|to_array}
		{$user->getEmail()|truncate:20:"..."|escape}&nbsp;{icon name="mail" url=$url}
	</td>
	<td align="right" class="nowrap">
		<!-- Comment out by EL on April 25, 2012: Too hazardous -->
		<!--
		{if $roleId}
		<a href="{url op="enroll" path=$roleId userId=$user->getId()}" class="action">{translate key="manager.people.enroll"}</a>
		{else}
		<a href="#" onclick="enrollUser({$user->getId()})" class="action">{translate key="manager.people.enroll"}</a>
		{/if}
		-->
		<a href="{url op="editUser" path=$user->getId()}" class="action">{translate key="common.edit"}</a>
		{if $thisUser->getId() != $user->getId()}
			{if $user->getDisabled()}
				|&nbsp;<a href="{url op="enableUser" path=$user->getId()}" class="action">{translate key="manager.people.enable"}</a>
			{else}
				|&nbsp;<a href="javascript:confirmAndPrompt({$user->getId()})" class="action">{translate key="manager.people.disable"}</a>
			{/if}
		{/if}
	</td>
</tr>
<tr><td colspan="6" class="{if $users->eof()}end{/if}separator">&nbsp;</td></tr>
{/iterate}
{if $users->wasEmpty()}
	<tr>
	<td colspan="6" class="nodata">{translate key="common.none"}</td>
	</tr>
	<tr><td colspan="6" class="endseparator">&nbsp;</td></tr>
{else}
	<tr>
		<td colspan="3" align="left">{page_info iterator=$users}</td>
		<td colspan="2" align="right">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth roleId=$roleId sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>

<input type="submit" id="submit" value="{translate key="manager.people.enrollSelected"}" class="button defaultButton" style="display: none;" /> 
<!-- Comment out by EL on April 25, 2012: Too hazardous -->
<!-- <input type="button" id="selectAll" value="{translate key="common.selectAll"}" class="button" onclick="toggleChecked()" /> -->
<input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url page="manager" escape=false}'" />


</form>

{if $backLink}
<a href="{$backLink}">{translate key="$backLinkLabel"}</a>
{/if}

{include file="common/footer.tpl"}

