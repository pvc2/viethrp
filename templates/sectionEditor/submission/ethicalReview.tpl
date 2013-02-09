{**
 * technicalReview.tpl
 *
 *
 * Display the technical review information once completed
 *
 *}
 
<div id="technicalReview">
	<h3>{translate key="common.ethicalReview"}</h3>
	<table width="100%" class="data">
		<tr>
			<td width="20%">{translate key="common.status"}</td>
			<td width="80%">
			{assign var="decision" value=$submission->getEditorDecisionKey()}
			{translate key=$decision}
			</td>
		</tr>
		{foreach from=$reviewAssignments item=reviewAssignment key=reviewKey}
			{if $reviewAssignment->getMostRecentPeerReviewComment() || $reviewAssignment->getReviewerFileRevisions() || $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
				<tr>
					<td width="20%">{$reviewAssignment->getReviewerFullName()|escape}</td>
					<td width="80%">
						<table width="100%" class="data">
							{if $reviewAssignment->getMostRecentPeerReviewComment()}
								<tr>
									<td width="20%">{translate key="submission.comments.comments"}:</td>
									<td width="80%">
										{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
										<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{$comment->getDatePosted()|date_format:$dateFormatLong}		
									</td>
								</tr>
							{/if}
							{if $reviewAssignment->getReviewerFileRevisions()}
								<tr>
									<td width="20%">{translate key="article.reviewFiles"}</td>
									<td width="80%">
										{foreach from=$reviewAssignment->getReviewerFileRevisions() item=reviewerFile key=key}
											<form name="authorView{$reviewAssignment->getId()}" method="post" action="{url op="makeReviewerFileViewable"}">
												<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewerFile->getDateModified()|date_format:$dateFormatLong}
												<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
												<input type="hidden" name="articleId" value="{$submission->getId()}" />
												<input type="hidden" name="fileId" value="{$reviewerFile->getFileId()}" />
												<input type="hidden" name="revision" value="{$reviewerFile->getRevision()}" />
												<br/>{translate key="editor.article.showAuthor"} <input type="checkbox" name="viewable" value="1"{if $reviewerFile->getViewable()} checked="checked"{/if} />
												<input type="submit" value="{translate key="common.record"}" class="button" />
											</form>
										{/foreach}
									</td>
								</tr>
							{/if}
							{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
								<tr>
									<td width="20%">{translate key="submission.recommendation"}:</td>
									<td width="80%">
										{assign var="recommendation" value=$reviewAssignment->getRecommendation()}
										{translate key=$reviewerRecommendationOptions.$recommendation}
										&nbsp;&nbsp;{$reviewAssignment->getDateCompleted()|date_format:$dateFormatLong}
									</td>
								</tr>
							{/if}
						<div class="separator"></div>
						</table>
					</td>
				</tr>
			{/if}
		{/foreach}
	</table>
</div>
