package com.emote

import javax.servlet.http.Cookie
import grails.plugin.facebooksdk.*

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
		User user = session.user
		String token = getFbToken() 			// For private data
		facebookGraphClient = new FacebookGraphClient(token)
		log.info "user.token ${token}"
		List followFriends = []
		List userFriends = []

		userFriends = facebookGraphClient.fetchConnection("${user.facebookId}/friends", [limit:200])
		List inviteFriends = []
		userFriends.each{friend ->
			User emoteUser = userService.findByFBId(friend.id)
			if(emoteUser != null){
				if(user.followingUsers == null ||  !user.followingUsers.contains(emoteUser.id)){
					followFriends.add(emoteUser)
				}
			}else{
				inviteFriends.add(friend)
			}
		}
		render (view:'displayUsers', model: [userFriends: inviteFriends, emoteUsersList: followFriends])

	}
	
	def follow(){
		User user = session.user
		if(user != null && params.friendId != null){
			userService.addFollowingUser(user, params.friendId)
		}
		render ("success")
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