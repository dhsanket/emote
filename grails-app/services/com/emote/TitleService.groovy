package com.emote

import java.util.Set;

class TitleService {

    def getSingleTitle(String titleId) {
		def titles = Title.get(titleId)
		if(titles==null)
			return null;
			
		return Emote.findAllByTitle(titles.getText()); 

    }
}
