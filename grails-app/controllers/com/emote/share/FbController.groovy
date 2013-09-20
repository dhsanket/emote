package com.emote.share

import javax.servlet.http.Cookie;

import grails.plugin.facebooksdk.FacebookGraphClient;

/*Not used now as grail's fb plugin was used for share and invite,
 in future it might be necessary*/
class FbController {

	FacebookGraphClient facebookGraphClient;
	
    /*def index() { }*/
	def share(){
		log.warn("working?")
		String token = getFbToken() 			// For private data
		facebookGraphClient = new FacebookGraphClient(token)
		log.info "user.token ${token}"
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
