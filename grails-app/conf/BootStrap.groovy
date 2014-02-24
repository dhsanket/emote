import com.emote.User

class BootStrap {

    def init = { servletContext ->
        development {
            def demoUser = User.findByFacebookId('1114675314')

            if(!demoUser) {
                new User(firstName: 'John', lastName: 'Doe', email: 'john.doe@gmail.com', facebookId: '1114675314').save(flush: true)
            }
        }
    }
    def destroy = {
    }
}