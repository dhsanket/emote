package com.emote

import groovy.json.JsonSlurper
import javax.servlet.http.Cookie
import grails.plugin.facebooksdk.*
import com.restfb.exception.FacebookOAuthException


class UserController 
{
	FacebookGraphClient facebookGraphClient;
	// this is required in sign in gsp to get URL after facebook login
	FacebookContext facebookContext;
	UserService userService;

	def signin()
	{
	}
	
	def displayUsers(){
		User user = session.user
		String token = getFbToken() 			// For private data
		facebookGraphClient = new FacebookGraphClient(token)
		log.info "user.token ${token}"
		List emoteUsersList = []
		List userFriends = []
		//TODO correct this write method on user service to get users by list of facebook id
		emoteUsersList = User.list()
		userFriends = facebookGraphClient.fetchConnection("${user.facebookId}/friends", [limit:10])
		//log.info "user friends in ${userFriends[1]},${userFriends[2] }"
        log.info "user friends in ${userFriends}"
		render (view:'displayUsers', model: [userFriends: userFriends, emoteUsersList: emoteUsersList])
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

}
