package com.emote

import groovy.json.JsonSlurper
import javax.servlet.http.Cookie
import grails.plugin.facebooksdk.*
import com.restfb.exception.FacebookOAuthException


class UserController 
{
	FacebookContext facebookContext;
	FacebookGraphClient facebookGraphClient;
//	def facebookGraphService;

	UserService userService;

	def signin()
	{

	}
	
	def signinAction()
	{
		User userEmote = userService.findByEmail(params.email)
		
		if(userEmote == null)
		{
			flash.message = "Keep Calm and Eat Cheese till we get you setup! Pls email us on sanketd367@gmail.com"
			redirect (action:'signin')
			return
		}
		
		if(userEmote.passcode.equals(params.passcode))
		{
			session.user = userEmote
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
		def me
		List userFriends = []
		String token = facebookContext.user.token  			// For private data
		facebookGraphClient = new FacebookGraphClient(token)
		
		if (facebookContext.authenticated)
		{
            if (token) {
                try {
                    me = facebookGraphClient.fetchObject(facebookContext.user.id.toString())
                    userFriends = facebookGraphClient.fetchConnection(me.id+"/friends", [limit:10])
                } catch (FacebookOAuthException exception) {
                    facebookGraphClient = new FacebookGraphClient() // Do not use invalid token anymore
                    facebookContext.user.invalidate()
                }
            }	
			// log.info "user with facebook id ${session.facebookContext.user.id} logged in"
			User userFB = userService.findByFBId(me.id)
			if(userFB == null)
			{
				//log.info "facebook  profile object ${fp}"
				//log.info "Going to create user ${fp.first_name} for ${fp.email}"
				// create new user and save
				userFB = userService.createUser(me.id, me.first_name, me.last_name, me.email)
				log.info "user saved with id= ${user.id}"
			}
			//user = userService.findByFBId(facebookContext.user.id)
			return userFriends
			session.user = userFB
			setLoginCookie(user.facebookId)
			String cntlr = flash.prevController == null?'emote':flash.prevController
			String act = flash.prevAction == null?'feed':flash.prevAction
			// redirect(controller:cntlr,action:act)
			redirect(action:'signin')
			
			/* JsonSlurper slurper = new JsonSlurper()
			def result = slurper.parseText(facebookGraphService.getFriends().toString())
			if(result != null)
			{
				
				 [fbFriends:result.data]
			}
			TOOD add cookie   */
		
	
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
