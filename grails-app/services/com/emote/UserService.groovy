package com.emote

class UserService {

    def findByFBId(String facebookId) {
		return User.findByFacebookId(facebookId)
    }

    /**
     * Given a list of user FB ids, returns a {@linkplain Map} with facebook id as key
     * and user id as value for just registered users
     *
     * @param facebookIds Set of facebook ids to look for
     * @return {@linkplain Map} of facebook id and user id
     */
    Map<String, String> filterRegisteredFbIds(Collection<String> facebookIds) {
        def list = User.withCriteria {
            projections {
                property('facebookId')
                id()
            }
            inList('facebookId', facebookIds)
        }

        def map = [:]
        list[0].eachWithIndex { String facebookId, int index ->
            map.put(facebookId, list[1][index])
        }

        map
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

}
