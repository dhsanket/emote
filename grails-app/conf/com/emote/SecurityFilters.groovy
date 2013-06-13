
package com.emote

import javax.servlet.http.Cookie


class SecurityFilters {
	UserService userService
	
	def filters = {
	/*	
		
		signinCheck(action:'*', actionExclude: 'feed') {
			before = {
				if(!actionName.toString().startsWith("sign")){
					if (!session.user && !loginCookieExist(request, session)) {
						flash.prevController = controllerName
						flash.prevAction = actionName
						redirect(controller:'user', action: 'signin')
						return false
					}
				}
			}
		}
		
		
	}
	
	private boolean loginCookieExist( def request,  def session){
		boolean exists = false
		Cookie [] cookies = request.getCookies()
		cookies.each{cookie ->
			if(cookie.getName() == "id"){
				Long facebookId = cookie.getValue()
				User user = userService.findByFBId(facebookId)
				if(user != null){
					session.user = user
					exists = true
				}
			}
			
		}
		return exists
		*/
	}	
	
}

