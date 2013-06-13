package com.emote

import groovy.json.JsonSlurper
import javax.servlet.http.Cookie
import grails.plugin.facebooksdk.*

class UserController 
{
	FacebookContext facebookContext;

//	def facebookGraphService;

	UserService userService;

	def signin()
	{
		User user = userService.findByEmail(params.email)
		
		if(user == null)
		{
			flash.message = "Oops! seems we havn't set you up yet. Pls email us on sanketd367@gmail.com"
			redirect (action:'signin')
			return
		}
		
		if(user.passcode.equals(params.passcode))
		{
			session.user = user
			setLoginCookie(user.facebookId)
			String cntlr = flash.prevController == null?'emote':flash.prevController
			String act = flash.prevAction == null?'feed':flash.prevAction
			redirect(controller:cntlr,action:act)
			return
		}
		flash.message = "Error! pls check your passcode again."
		redirect (action:'signin')
	}

	def storeFBUser()
	{
		if (facebookContext.authenticated) 
		{
    // User is authenticated
			
			log.info "user with facebook id ${session.facebook.uid} logged in"
			User user = userService.findByFBId(facebookContext.user.id)
			if(user == null)
			{
				def fp = facebookContext.user()
				log.info "facebook  profile object ${fp}"
				log.info "Going to create user ${fp.first_name} for ${fp.email}"
				// create new user and save
				user = userService.createUser(fp.id, fp.first_name, fp.last_name, fp.email)
				log.info "user saved with id= ${user.id}"
			}
			session.user = user
			setLoginCookie(user.facebookId)
			JsonSlurper slurper = new JsonSlurper()
			//def result = slurper.parseText(facebookGraphService.getFriends().toString())
			if(result != null)
			{
				[fbFriends:result.data]
			}
			//TOOD add cookie
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
		render 'you have successfully logged out'
	}

	private void setLoginCookie(String facebookId)
	{
		Cookie cookie = new Cookie("id", facebookId)
		cookie.setMaxAge(365*24*60*60)
		cookie.setPath("/")
		response.addCookie(cookie)
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
