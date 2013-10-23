package com.emote

class NotificationsController {

    def count() {
		int count = 0;
		if(session.notifications){
			count = session.notifications.size()
		}
		render ""+count;
	}
	
	def show(){
		render(contentType: "text/json") {
			 array {
				for (n in session.notifications) {
					notification  title: n.title, message: n.message 
				}
			}
		}
	}
}
