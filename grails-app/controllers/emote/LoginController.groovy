package emote

class LoginController {

    def facebookGraphService;

    def success(){

    }

    def friends(){
        [fbfriends:facebookGraphService.getFriends().toString()]
    }

    def fail(){

    }

    def index() {
        render (view : "login.gsp")
    }

    def test(){

    }
}
