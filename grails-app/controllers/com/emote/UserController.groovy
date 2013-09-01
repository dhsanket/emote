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

}
