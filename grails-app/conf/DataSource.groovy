grails {
	mongo {
		databaseName = "app14658629"
		dbCreate = "update"
		host = "dharma.mongohq.com"
		port = 10046
		username = "emote-app"
		password = "Emote-101"

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
			databaseName = "app14658629"
			dbCreate = "update"
		host = "dharma.mongohq.com"
		port = 10046
			username = "emote-app"
			password = "Emote-101"
	
		}
	}
}
