package com.emote

import groovy.json.JsonSlurper

class UserController {
	
	def facebookGraphService;
	
	UserService userService;
	
    def signin() { 
		
	}
	
	def signin2(){
		
	}
	
	def doSignin(){
		User user = userService.findByEmail(params.email)
		
		if(user == null){
			flash.message = "Oops! seems we havn't set you up yet. Pls email us on sanketd367@gmail.com"
			redirect (action:'signin2')
			return
		}
		if(user.passcode.equals(params.passcode)){
			redirect(controller:'emote',action:'feed')
			return
		}
		flash.message = "Error! pls check your passcode again."
		redirect (action:'signin2')

	}
	
	def invite(){
		User user = userService.findByFBId(session.facebook.uid)
		if(user == null){
			log.info "Going to create user ${params.name} for ${params.emailId}"
			// create new user and save
			user = userService.findByFBId(params.fbId)
			if(user == null){
				userService.createUser(params.fbId, params.name, params.surname, params.emailId)
				println "user saved"
				
			}else{
				log.info "found user for fbId ${params.fbId} email ${user.emailId}"
			}
			
		}
		session.user = user
		JsonSlurper slurper = new JsonSlurper()
		//def result = slurper.parseText(facebookGraphService.getFriends().toString())
		
		String jsonText;
		new File("D:\\Users\\Nitin\\development\\workspace-ggts-3.2.0.RELEASE\\sandpit\\test\\unit\\sandpit\\fb_friends.json").eachLine{ line ->
			jsonText = line
		}
		def result = slurper.parseText(jsonText)

		if(result != null){
			[fbFriends:result.data]
		}
		
	}
	
	def settings(){
		
	}
	
	def profile(){
		
		
	}
}
