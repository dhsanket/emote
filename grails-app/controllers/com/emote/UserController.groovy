package com.emote

import groovy.json.JsonSlurper
import javax.servlet.http.Cookie
import grails.plugin.facebooksdk.*
import com.restfb.exception.FacebookOAuthException


class UserController 
{
	FacebookContext facebookContext;
	FacebookGraphClient facebookGraphClient;

	UserService userService;

	def signin()
	{
	}
	
	def followUsers(){
		String token = facebookContext.user.token  			// For private data
		facebookGraphClient = new FacebookGraphClient(token)
		log.info "user.token expired? ${facebookContext.user.tokenExpired}"
		log.info "user authenticated ? ${facebookContext.authenticated}"
		log.info "FB context user ${facebookContext.user.id}"
		log.info "user.token ${token}"
		List emoteUsersList = []
		List userFriends = []
		if (facebookContext.authenticated)
		{	
			log.info "user is FB authenticated"
			emoteUsersList = User.list()
			userFriends = facebookGraphClient.fetchConnection("${facebookContext.user.id}/friends", [limit:10])
			log.info "user friends in ${userFriends[1]},${userFriends[2] }"
			render (view:'followUsers', model: [userFriends: userFriends, emoteUsersList: emoteUsersList])
		}
		else{
		log.info "user is NOT FB authenticated"
			redirect (controller:'emote', action: 'feed')
		}	
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
			if(cookie.getName() == "id")
			{
				cookie.setMaxAge(0)
				cookie.setPath("/")
				log.info "deleted login cookie"
				response.addCookie(cookie)
			}
		}
	}

}
