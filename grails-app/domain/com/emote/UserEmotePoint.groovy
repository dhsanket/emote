package com.emote

import java.util.Date;

class UserEmotePoint {
	Date dateCreated
	Date lastUpdated
    String userId
    String emoteId
    Point point = Point.NONE

    static constraints = {

    }

    boolean equals(o) {
        if (this.is(o)) return true
        if (getClass() != o.class) return false

        UserEmotePoint point = (UserEmotePoint) o

        if (emoteId != point.emoteId) return false

        return true
    }

    int hashCode() {
        return (emoteId != null ? emoteId.hashCode() : 0)
    }
    enum Point{
        NEGATIVE(-1),
        POSITIVE(1),
        NONE(0)

        private int choice

        Point(int choice){
            this.choice = choice
        }
    }

}
