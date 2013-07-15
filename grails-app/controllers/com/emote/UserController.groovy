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
		
		List emoteUsersList = []
		List userFriends = []
		if (facebookContext.authenticated)
		{
			emoteUsersList = User.list()
			userFriends = facebookGraphClient.fetchConnection("${facebookContext.user.id}/friends", [limit:10])
			// log.info "user friends in ${userFriends[1]},${userFriends[2] }"
			flash.titles = emoteService.groupByTitle(emoteService.feed())
			render (view:'followUsers', model: [userFriends: userFriends, emoteUsersList: emoteUsersList])
		}
		else
			redirect (controller:'emote', action: 'feed')
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
