package emote

class GitAutoController {

    def index() {
		log.info "executing git auto"
		def process = "git pull git@github.com:dhsanket/emote.git".execute()
		render ("output - ${process.text}")
	}
}
