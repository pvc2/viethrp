<?php

import('lib.pkp.classes.who.Meeting');

class MeetingDAO extends DAO {
	/**
	 * Constructor
	 */
	var $userDao;
	function MeetingDAO() {
		parent::DAO();
		$this->userDao &= DAORegistry::getDAO('UserDAO');
	}

	/**
	 * Get meeting object
	 * @param $meeting int
	 * @return Meeting
	 */
	function &getMeetingsOfUser($userId, $sortBy = null, $sortDirection = SORT_DIRECTION_ASC) {
		$meetings = array();
		$sql = 'SELECT meeting_id, meeting_date, user_id, status, final FROM meetings as a WHERE user_id = ?';
		if ($sortBy) {
			$sql .=  ' ORDER BY ' . $this->getSortMapping($sortBy) . ' ' . $this->getDirectionMapping($sortDirection);
		}
		$result =& $this->retrieve(
			$sql, (int) $userId
		);

		while (!$result->EOF) {
			$meetings[] =& $this->_returnMeetingFromRow($result->GetRowAssoc(false));
			$result->MoveNext();
		}

		$result->Close();
		unset($result);

		return $meetings;
	}
	
	/**
	 * Get meeting object
	 * @param $meeting int
	 * @return Meeting
	 */
	function &getMeetingById($meetingId) {
		$meeting = null;
		
		//Added field 'final'
		//Edited by ayveemallare 7/6/2011
		
		$result =& $this->retrieve(
			'SELECT meeting_id, user_id, meeting_date, status, final FROM meetings WHERE meeting_id = ?',
			(int) $meetingId
		);
		
		$meeting =& $this->_returnMeetingFromRow($result->GetRowAssoc(false));
		
		$result->Close();
		unset($result);

		return $meeting;
	}
	
	/**
	 * Get all meetings to be attended by reviewer
	 * Added by ayveemallare 7/6/2011
	 * 
	 * @param unknown_type $reviewerId
	 */
	function &getMeetingsByReviewerId($reviewerId, $sortBy = null, $sortDirection = SORT_DIRECTION_ASC) {
		$meetings = array();
		$sql = 
			'SELECT * 
			FROM meetings a INNER JOIN meeting_reviewers b
			ON a.meeting_id = b.meeting_id WHERE b.reviewer_id= ?';
		if ($sortBy) {
			$sql .=  ' ORDER BY ' . $this->getSortMapping($sortBy) . ' ' . $this->getDirectionMapping($sortDirection);
		}
		$result =& $this->retrieve(
			$sql,(int) $reviewerId );
		while (!$result->EOF) {
			$meetings[] =& $this->_returnMeetingFromRow($result->GetRowAssoc(false));
			$result->MoveNext();
		}

		$result->Close();
		unset($result);

		return $meetings;
	}
	
	/**
	 * Get meeting by meetingId and reviewerId
	 * Added by ayveemallare 7/6/2011
	 * 
	 * @param int $meetingId
	 * @param int $reviewerId
	 */
	function &getMeetingByMeetingAndReviewerId($meetingId, $reviewerId) {
		$meeting = null;
		$result =& $this->retrieve(
			'SELECT * 
			FROM meetings a INNER JOIN meeting_reviewers b
			ON a.meeting_id = b.meeting_id WHERE a.meeting_id = ? AND b.reviewer_id= ?',
			array((int) $meetingId, (int) $reviewerId));
		
		$meeting =& $this->_returnMeetingFromRow($result->GetRowAssoc(false));
		
		$result->Close();
		unset($result);

		return $meeting;
	}

	
	/**
	 * Internal function to return an meeting object from a row. Simplified
	 * not to include object settings.
	 * @param $row array
	 * @return Meeting
	 */
	function &_returnMeetingFromRow(&$row) {
		$meeting = new Meeting();
		$meeting->setId($row['meeting_id']);
		$meeting->setDate($row['meeting_date']);
		$meeting->setUploader($row['user_id']);
		$meeting->setStatus($row['status']);
				
		//Added additional fields
		//Edited by ayveemallare 7/6/2011
		$meeting->setReviewerId($row['reviewer_id']);
		$meeting->setIsAttending($row['attending']);
		$meeting->setRemarks($row['remarks']);
		$meeting->setIsFinal($row['final']);
		
		HookRegistry::call('MeetingDAO::_returnMeetingFromRow', array(&$meeting, &$row));
		return $meeting;
	}

	/**
	 * Get a new data object
	 * @return DataObject
	 */
	function newDataObject() {
		assert(false); // Should be overridden by child classes
	}

	function insertMeeting($userId, $meetingDate = null, $status = 0) {
		$this->update(
			sprintf('INSERT INTO meetings (meeting_date, user_id, status) VALUES (%s, ?, ?)',
			$this->datetimeToDB($meetingDate)),
			array($userId, $status)
		);		
	}
	
	function &createMeeting($userId, $meetingDate = null, $status = 0) {
		$this->insertMeeting($userId, $meetingDate, $status);
				
		$meetingId = 0;
		$result =& $this->retrieve(
			'SELECT max(meeting_id) as meeting_id, meeting_date, user_id, status FROM meetings WHERE user_id = ? GROUP BY meeting_id ORDER BY meeting_id DESC LIMIT 1;',
			(int) $userId
		);
		$row = $result->GetRowAssoc(false);
		$meetingId = $row['meeting_id'];
						
		$result->Close();
		unset($result);

		return $meetingId;
	}
	
	function updateMeetingDate($meeting) {
		$this->update(
			sprintf('UPDATE meetings SET meeting_date = %s where meeting_id = ?',$this->datetimeToDB($meeting->getDate())),
			array($meeting->getId())
		);				
	}
	
	function updateStatus($meeting) {
		$this->update(
			'UPDATE meetings SET status = ? where meeting_id = ?',
			array($meeting->getStatus(), $meeting->getId())
		);
	}
	
	function getSortMapping($heading) {
		switch ($heading) {
			case 'id': return 'a.meeting_id';
			case 'meetingDate': return 'meeting_date';
			case 'replyStatus': return 'attending';
			case 'scheduleStatus': return 'final';
			default: return null;
		}
	}
	
	/**
	 * Set meeting final
	 * Added by MSB July 7, 2011
	 */
	
	function setMeetingFinal($meetingId){
		$this->update(
			'UPDATE meetings SET final = ? where meeting_id = ?',
			array(1,$meetingId)
		);
	} 
	
	function cancelMeeting($meetingId){
		$this->update(
			'DELETE a,b,c FROM meetings AS a
			 LEFT JOIN meeting_submissions AS b ON (b.meeting_id = a.meeting_id)
			 LEFT JOIN meeting_reviewers AS c ON (c.meeting_id = b.meeting_id)
			 WHERE c.meeting_id = ?',
			(int) $meetingId
		);
	}
		
}

?>
