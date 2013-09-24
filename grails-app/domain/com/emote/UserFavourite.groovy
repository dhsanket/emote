package com.emote

class UserFavourite {
    String userId
    Set<String> favouriteTitles = new HashSet<String>();
    static constraints = {
        userId nullable: false
    }
}
