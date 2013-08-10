package com.emote

import grails.plugin.facebooksdk.*

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
		return user
	}
	
	def addFollowingUser(User user, String userId){
		if(user.followingUsers == null)
			user.followingUsers = new HashSet<String>()
		user.followingUsers.add(userId)
		user.save()
		
	}
}
