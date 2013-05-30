package com.emote

import groovy.json.JsonSlurper
import javax.servlet.http.Cookie

class UserController {
	
	def facebookGraphService;
	
	UserService userService;
	
    def signin() { 
		
	}
	
	def signin2(){
		
	}
	
	def signinAction(){
		
		User user = userService.findByEmail(params.email)
		
		if(user == null){
			flash.message = "Oops! seems we havn't set you up yet. Pls email us on sanketd367@gmail.com"
			redirect (action:'signin2')
			return
		}
		if(user.passcode.equals(params.passcode)){
			session.user = user
			setLoginCookie(user.facebookId)
			String cntlr = flash.prevController == null?'emote':flash.prevController 
			String act = flash.prevAction == null?'feed':flash.prevAction
			redirect(controller:cntlr,action:act)
			return
		}
		flash.message = "Error! pls check your passcode again."
		redirect (action:'signin2')

	}
	
	def signinAndInvite(){
		User user = userService.findByFBId(session.facebook.uid)
		if(user == null){
			log.info "Going to create user ${params.name} for ${params.emailId}"
			// create new user and save
			user = userService.findByFBId(params.fbId)
			if(user == null){
				user = userService.createUser(params.fbId, params.name, params.surname, params.emailId)
				log.info "user saved"
				
			}else{
				log.info "found user for fbId ${params.fbId} email ${user.emailId}"
			}
			
		}
		session.user = user
		JsonSlurper slurper = new JsonSlurper()
		def result = slurper.parseText(facebookGraphService.getFriends().toString())
		
//		String jsonText;
//		new File("D:\\Users\\Nitin\\development\\workspace-ggts-3.2.0.RELEASE\\sandpit\\test\\unit\\sandpit\\fb_friends.json").eachLine{ line ->
//			jsonText = line
//		}
//		def result = slurper.parseText(jsonText)

		if(result != null){
			[fbFriends:result.data]
		}
		
//		response.addCookie(createLoginCookie(user.facebookId))
		
	}
	
	def settings(){
		
	}
	
	def profile(){
		
		
	}
	
	def signout(){
		User user = session.user
		if(user != null){
			deleteCookie(user.facebookId)
		}
		session.user = null
		render 'you have successfully logged out'
	}
	
	private void setLoginCookie(String facebookId){
		Cookie cookie = new Cookie("id", facebookId)
		cookie.setMaxAge(365*24*60*60)
		cookie.setPath("/")
		response.addCookie(cookie)
	}
	
	private void deleteCookie(String facebookId){
		
		request.getCookies().each{ cookie ->
			if(cookie.getName() == "id"){
				cookie.setMaxAge(0)
				cookie.setPath("/")
				log.info "deleted login cookie"
				response.addCookie(cookie)
			}
		}
	}


	
	
}
