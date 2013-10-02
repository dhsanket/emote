package com.emote

import java.util.Date;

class Flag {
	
	Date dateCreated
	Date lastUpdated
    String id
    String title
    Integer type
    String comment
    static constraints = {
        //comment blank:false
    }
}
