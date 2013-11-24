
package com.emote

import grails.plugin.facebooksdk.FacebookContext;
import grails.plugin.facebooksdk.FacebookGraphClient;

import javax.servlet.http.Cookie


class SecurityFilters {
	UserService userService
	
	NotificationService notificationService
	
	FacebookContext facebookContextProxy
	
	def filters = {
	
		loginCookieCheck(action:'*', controllerExclude : 'picture'){
			before = {
				if(session.user == null){
					putUserInSessionIfCookieExist(request, session)
//					fetchNotifications(session)
					return true;
				}
			}
		}
		
		signinCheck(action:'*', actionExclude: "signin|findUserInDB|feed|singleTitle|index", controllerExclude : 'picture') {
			before = {
					if (session.user == null) {
						redirect(controller:'user', action: 'signin')
						return false
					}
			}
		}
		
		signinSession(controller:'user', action:'signin'){
			before = {
				if(session.user){
					redirect(controller:'emote', action: 'feed')
				}
			}
		}
		
		
	}
	
	
	private void putUserInSessionIfCookieExist( def request,  def session){
		Cookie [] cookies = request.getCookies()
		cookies.each{cookie ->
			if(cookie.getName() == "id"){
				String facebookId = cookie.getValue()
				User user = userService.findByFBId(facebookId)
				if(user != null){
					session.user = user
					user.lastAccessTime = new Date()
					user.save(flush:true)
				}
			}
			
		}
	
	}
	
	private void fetchNotifications(def session){
		def notifications = notificationService.getNotifications(session.user)
		session.notifications = notifications
	}

	
	


	
}

