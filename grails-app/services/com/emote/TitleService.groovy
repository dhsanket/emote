package com.emote

import groovy.time.TimeCategory

class TitleService {

    //todo sina: I don't know why it is here, it's about emote,not title
    def getSingleTitle(String title) {
		/*def titles = Title.get(titleId)
		if(titles==null)
			return null;*/
		return Emote.findAllByTitle(title); 

    }

    /**
     * Filter "doing now" titles
     *
     * @param titles
     * @param userId
     * @return A new set with just those {@linkplain Title} ids marked as "Doing now"
     */
    Collection<String> filterDoingNow(Collection<String> titles, String userId) {
        Collection<String> result = []
        if(userId) {
            result = UserDoing.withCriteria {
                projections {
                    property('title')
                }
                eq('userId', userId)
                inList('title', titles)
                gt('lastUpdated', use(TimeCategory){new Date() - 1.hours})
            } as Collection<String>
        }
        result
    }

    /**
     * Filter "in to do list" titles
     *
     * @param titles
     * @param userId
     * @return A new set with just those {@linkplain Title} ids already in the user TO DO list
     */
    Collection<String> filterInToDoList(Collection<String> titles, String userId) {
        Collection<String> result = []
        if(userId) {
            result = UserToDo.withCriteria {
                projections {
                    property('title')
                }
                eq('userId', userId)
                inList('title', titles)
            } as Collection<String>
        }
        result
    }

}
