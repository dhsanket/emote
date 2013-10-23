package com.emote

class NotificationQueue {
    String userId
    String title
    String message
    Boolean notified = false
    Boolean mailed = false
	Date creationTime
    static constraints = {
        message nullable: true
    }
}
