package com.emote

import com.restfb.Connection
import com.restfb.Parameter
import grails.converters.JSON
import grails.plugin.facebooksdk.FacebookContext
import grails.plugin.facebooksdk.FacebookGraphClient

import javax.servlet.http.Cookie

class UserController
{
	FacebookGraphClient facebookGraphClient;
	// this is required in sign in gsp to get URL after facebook login
	FacebookContext facebookContext;
	UserService userService;

	def signin()
	{
	}
	
	def landingPage()
	{
        render (view:'/landingPage')
	}
	
	def findUserInDB(){
		log.info "looking for user in emote DB"
		def me
		User user
		User userFB

		if (facebookContext.authenticated)
		{
			
				String token = null
				Cookie [] cookies = request.getCookies()
				cookies.each{cookie ->
					if(cookie.getName() == "fbt"){
						token = cookie.getValue()
						log.info "Got FB token from Cookie"
					}
				}
			if(token == null)
				token = facebookContext.user.token
				log.info "Got FB token from FB itself"
			FacebookGraphClient facebookGraphClient = new FacebookGraphClient(token)

			if (token) {
				try {
					// Exchange token to get an extended expiration time (60 days)
					log.info "Current token expiration time: " + new Date(facebookContext.user.tokenExpirationTime)
					facebookContext.user.exchangeToken()
					log.info "Exchanged token expiration time:  " + new Date(facebookContext.user.tokenExpirationTime)
					me = facebookGraphClient.fetchObject(facebookContext.user.id.toString())

				} catch (Throwable e) {
					log.error("Terrible thing happed while fb login" , e)
					facebookGraphClient = new FacebookGraphClient() // Do not use invalid token anymore
					facebookContext.user.invalidate()
				}
			}
			// log.info "user with facebook id ${session.facebookContext.user.id} logged in"
			userFB = userService.findByFBId(me.id)
			if(userFB == null)
			{
				//log.info "facebook  profile object ${fp}"
				//log.info "Going to create user ${fp.first_name} for ${fp.email}"
				// create new user and save
				userFB = userService.createUser(me.id, me.first_name, me.last_name, me.email)
				log.info "user saved with id= ${userFB.facebookId}"  //
			}
			//user = userService.findByFBId(facebookContext.user.id)
			//return userFriends
			session.user = userFB
			setLoginCookie(session.user.facebookId, token,  response)
			redirect(controller:'emote' , action:'feed')
			return
		}
		log.info " did not find facebook Context"
		redirect(controller:'emote' , action:'index')
		return ;
	}
	
	def displayUsers(){
        // To read updated user state
		User user = User.findById(session.user.id as String)
		String token = getFbToken() 			// For private data
		facebookGraphClient = new FacebookGraphClient(token)
		log.info "user.token ${token}"

		List<com.restfb.types.User> facebookFriends = []
        Map actions = [:]

        Connection<com.restfb.types.User> usersConnection = facebookGraphClient.fetchConnection(
            "${user.facebookId}/friends",
            com.restfb.types.User,
            Parameter.with('limit', 5000)
        )

        facebookFriends.addAll(usersConnection.data)

        Map<String, String> registeredUsers = userService.filterRegisteredFbIds(facebookFriends.collect {it.id})

        facebookFriends.each {
            def isRegistered = registeredUsers.containsKey(it.id)
            String status = 'invite'

            if(isRegistered) {
                if(!user.followingUsers.contains(it.id)) {
                    status = 'follow'
                } else {
                    status = 'following'
                }
            }

            actions.put(it.id, [
                status: status,
                userId: registeredUsers[it.id]
            ])
        }

        facebookFriends.sort {it.name}

		render (view:'displayUsers', model: [userFriends: facebookFriends, actions: actions])

	}
	
	def follow(String friendId){
		User user = session.user
		if(user != null && friendId != null){
			userService.addFollowingUser(user, friendId)
		}

		render([success: true] as JSON)
	}

	def settings(){}

	def profile(){}

	def signout()
	{
		User user = session.user
		if(user != null)
		{
			deleteCookie(user.facebookId)
			
		}
		session.user = null
		//facebookContext.user.invalidate()
		redirect (action: 'signin')
	}
	

	private void deleteCookie(String facebookId)
	{
		request.getCookies().each
		{ cookie ->
			if(cookie.getName() == "id" || cookie.getName()== "fbt")
			{
				cookie.setMaxAge(0)
				cookie.setPath("/")
				log.info "deleted login cookie"
				response.addCookie(cookie)
			}
		}
	}
	
	private String getFbToken(){
		String token = null
		Cookie [] cookies = request.getCookies()
		cookies.each{cookie ->
			if(cookie.getName() == "fbt"){
				token = cookie.getValue()
			}
		}
		return token;
	}
	
	private void setLoginCookie(String facebookId, String token, def response)
	{
		Cookie cookie = new Cookie("id", facebookId)
		cookie.setMaxAge(60*24*60*60)
		cookie.setPath("/")
		response.addCookie(cookie)
		
		Cookie fbtcookie = new Cookie("fbt", token)
		fbtcookie.setMaxAge(60*24*60*60)
		fbtcookie.setPath("/")
		response.addCookie(fbtcookie)

	}

}