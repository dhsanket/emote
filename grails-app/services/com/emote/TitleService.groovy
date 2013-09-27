package com.emote

import java.util.Set;

class TitleService {

    //todo sina: I don't know why it is here, it's about emote,not title
    def getSingleTitle(String title) {
		/*def titles = Title.get(titleId)
		if(titles==null)
			return null;*/
		return Emote.findAllByTitle(title); 

    }
}
