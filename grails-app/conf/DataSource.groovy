grails {
	mongo {
	}
  }

// environment specific settings
environments {
	development {
		mongo {
			dbCreate = "update"
			databaseName = "emote"
			host = "localhost"
			port = 27017
	

		}
	}
	test {
		mongo {
			dbCreate = "update"

		}
	}
	production {
		mongo {
			databaseName = "app14660500"
			dbCreate = "update"
			host = "linus.mongohq.com"
			port = 10081
			username = "emote-app"
			password = "Emote-101"
	
		}
	}
}
