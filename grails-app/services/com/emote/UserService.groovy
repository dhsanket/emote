package com.emote

class UserService {

    def findByFBId(String facebookId) {
		return User.findByFacebookId(facebookId)
    }
	
	def findById(String uid) {
		return User.findById(uid)
	}

	
	def findByEmail(String emailId) {
		log.info "Finding user using email ${emailId}"
		return User.findByEmail(emailId)
	}

	
	def createUser(String fbId,String name, String lastname, String emailId){
		User user = new User(facebookId:fbId,
			firstName:name, lastName:lastname, email:emailId
			)
		user.save()
		return user
	}
	
	def addFollowingUser(User user, String userId){
		if(user.followingUsers == null)
			user.followingUsers = new HashSet<String>()
		user.followingUsers.add(userId)
		user.save()
		
	}

    def addFavouriteTitle(User user, String title){
        if(!user.favouriteTitles){
            user.favouriteTitles = new HashSet<String>()
        }
        user.favouriteTitles.add title
        user.save()
    }

    def removeFavouriteTopic(User user, String title) {
        if(user.favouriteTitles){
            user.favouriteTitles.remove title
            user.save()
        }
    }
}
