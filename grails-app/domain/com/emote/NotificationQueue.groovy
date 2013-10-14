package com.emote

class NotificationQueue {
    String userId
    String title
    String message
    Boolean userNotified = false
    Boolean userRead = false
    Boolean mailed = false
    static constraints = {
        message nullable: true
    }
}
