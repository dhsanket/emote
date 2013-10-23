package com.emote

import java.util.concurrent.Callable
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.ThreadFactory;

class NotificationService {
	
	ExecutorService workerPool = Executors.newFixedThreadPool(5)
    
	/**
	 * Notify update to Title asynchronously
	 * @param title
	 * @param parentTitle
	 * @param editor
	 * @return
	 */
    def notifyTitleUpdate(Title title, Title parentTitle, User editor) {
		//workerPool.submit(new NotifyTask(title, parentTitle, editor))
    }
	
	/**
	 * register title interest asynchronously
	 * @param title
	 * @param user
	 * @param type
	 * @return
	 */
	def registerInterest(String title, User user, TitleInterest.Type type){
		//workerPool.submit(new RegisterTask(title, user, type))
	}
	
	
	def List<NotificationQueue> getNotifications(User user){
		List<NotificationQueue> notifications = NotificationQueue.findAllByUserIdAndNotified(user.id, false)
		log.info "found $notifications.size() for user $user.firstName $user.lastName"
		return notifications
	}
	
	
	class NotifyTask implements Callable{
		private final Title title;
		private final Title parentTitle;
		private final User editor;
		
		

		public NotifyTask(Title title, Title parentTitle, User editor) {
			this.title = title;
			this.parentTitle = parentTitle;
			this.editor = editor;
		}



		@Override
		public Object call() throws Exception {
			//log.info "executing notify task for $title, $parentTitle, $editor"
			TitleInterest.findAllByTitleId(title.id).each(){interest ->
				if( interest.userId != editor.id){
				// log.info "found interest $interest " 
				 Date ct = new Date()
					NotificationQueue notification = new NotificationQueue(userId:interest.userId, 
						title:title.text, message:"$editor.firstName $editor.lastName has emoted on $title.text",
						creationTime:ct)
					notification.save(flush:true)
					//log.info "saved $notification"
				}
			}
		}
		
	}
	
	class RegisterTask implements Callable{
		private final String title;
		private final User user;
		private final TitleInterest.Type type;

		public RegisterTask(String title, User user, TitleInterest.Type type) {
			this.title = title;
			this.type = type;
			this.user = user;
		}

		@Override
		public Object call() throws Exception {
			Title t = Title.findByText(title)
			if(t){
				//TODO add interest once
				TitleInterest i = TitleInterest.findByTitleIdAndUserId(t.id, user.id)
				if(!i){
					TitleInterest interest = new TitleInterest(titleId:t.id, userId:user.id, type:type)
					interest.save(flush: true)
					//log.info "saved new interest $interest"
				}
				
			}
	
		}
		
	}

	
}
