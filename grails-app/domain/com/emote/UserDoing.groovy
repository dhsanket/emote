package com.emote

import groovy.time.TimeCategory

class UserDoing {
    String userId
    String title
    Date dateCreated
    Date lastUpdated
    Integer count
    Boolean notified = false

    static boolean isDoing(String userId, String title) {
        findByUserIdAndTitleAndLastUpdatedGreaterThan(userId,title, use(TimeCategory){new Date() - 1.hours})!=null
    }
    static constraints = {
        title blank: false
    }
}
