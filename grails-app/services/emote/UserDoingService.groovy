package emote

import com.emote.User
import com.emote.UserDoing

class UserDoingService {

    def addDoing(String userId, String title) {
        UserDoing userDoing =UserDoing.findByUserIdAndTitle(userId,title)
        if(userDoing){
            userDoing.count++
            userDoing.lastUpdated = new Date()
            userDoing.save()
        }
        else{
            new UserDoing(userId: userId,title: title,count: 1).save()
        }


    }
}
