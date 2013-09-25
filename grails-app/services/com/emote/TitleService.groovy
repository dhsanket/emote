package com.emote

import java.util.Set;

class TitleService {

    def getSingleTitle(String title) {
		/*def titles = Title.get(titleId)
		if(titles==null)
			return null;*/
		return Emote.findAllByTitle(title); 

    }
}
