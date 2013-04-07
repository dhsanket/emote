package emote

class GitAutoController {

    def index() {
		def process = "git pull git@github.com:dhsanket/emote.git".execute()
		render ("output - ${process.text}")
	}
}
