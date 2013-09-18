package com.emote

import java.util.Set;

class TitleService {

    def getSingleTitle(String titleId) {
		def titles = Title.get(titleId)
		if(titles==null)
			return null;
			
		return Emote.findAllByTitle(titles.getText()); 

    }
    def addFavouriteTitle(User user, String title){
        def favorite = UserFavourite.findOrCreateByUserId(user.id)
        if(!favorite.favouriteTitles){
            favorite.favouriteTitles = new HashSet<String>()

        }
        favorite.favouriteTitles.add title
        favorite.save()
    }

    def removeFavouriteTopic(User user, String title) {
        def favorite = UserFavourite.findOrCreateByUserId(user.id)
        if(!favorite.favouriteTitles){
            favorite.favouriteTitles = new HashSet<String>()

        }
        favorite.favouriteTitles.remove title
        favorite.save()
    }

}
