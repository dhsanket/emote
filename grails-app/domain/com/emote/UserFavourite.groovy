package com.emote

import java.util.Date;

class UserFavourite {
	Date dateCreated
	Date lastUpdated
    String userId
    Set<String> favouriteTitles = new HashSet<String>();
    static constraints = {
        userId nullable: false
    }
}
