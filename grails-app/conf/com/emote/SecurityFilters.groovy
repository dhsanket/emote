
package com.emote

import grails.plugin.facebooksdk.FacebookContext;
import grails.plugin.facebooksdk.FacebookGraphClient;

import javax.servlet.http.Cookie


class SecurityFilters {
	UserService userService
	
	FacebookContext facebookContextProxy
	
	def filters = {
	
		
		signinCheck(action:'*', actionExclude: 'signin') {
			before = {
					if (!session.user && !loginCookieExist(request, session) && !loggedInToFB(request, session, response)) {
						redirect(controller:'user', action: 'signin')
						return false
					}
			}
		}
		
		
	}
	
	private boolean loginCookieExist( def request,  def session){
		boolean exists = false
		Cookie [] cookies = request.getCookies()
		cookies.each{cookie ->
			if(cookie.getName() == "id"){
				String facebookId = cookie.getValue()
				User user = userService.findByFBId(facebookId)
				if(user != null){
					session.user = user
					exists = true
				}
			}
			
		}
		return exists
	
	}
	
	private boolean loggedInToFB(def request,  def session, def response){
		def me
		User user
		User userFB
		boolean fblogin = false
		if (facebookContextProxy.authenticated)
		{
			
			String token = facebookContextProxy.user.token  			
			FacebookGraphClient facebookGraphClient = new FacebookGraphClient(token)
			if (token) {
				try {
					me = facebookGraphClient.fetchObject(facebookContextProxy.user.id.toString())

				} catch (Throwable e) {
					log.error("Terrible thing happed while fb login" , e)
					facebookGraphClient = new FacebookGraphClient() // Do not use invalid token anymore
					facebookContextProxy.user.invalidate()
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
				log.info "user saved with id= ${user.id}"
			}
			//user = userService.findByFBId(facebookContext.user.id)
			//return userFriends
			session.user = userFB
			setLoginCookie(session.user.facebookId, response)
			fblogin = true
		}

		return fblogin;
	}
	
	
	private void setLoginCookie(String facebookId, def response)
	{
		Cookie cookie = new Cookie("id", facebookId)
		cookie.setMaxAge(365*24*60*60)
		cookie.setPath("/")
		response.addCookie(cookie)
	}

	
}

