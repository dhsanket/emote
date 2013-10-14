
package com.emote

import grails.plugin.facebooksdk.FacebookContext;
import grails.plugin.facebooksdk.FacebookGraphClient;

import javax.servlet.http.Cookie


class SecurityFilters {
	UserService userService
	
	FacebookContext facebookContextProxy
	
	def filters = {
	
		
		signinCheck(action:'*', actionExclude: "signin|findUserInDB|feed|singleTitle", controllerExclude : 'picture') {
			before = {
					if (!loginCookieExist(request, session) ) {
						redirect(controller:'user', action: 'signin')
						return false
					}
			}
		}
		
		signinSession(controller:'user', action:'signin'){
			before = {
				if(loginCookieExist(request, session)){
					redirect(controller:'emote', action: 'feed')
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
	

	
	


	
}

