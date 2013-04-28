package com.emote

class UserService {

    def findByFBId(String facebookId) {
		return User.findByFacebookId(facebookId)
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
	}
}
