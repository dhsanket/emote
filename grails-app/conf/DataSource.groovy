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
			databaseName = "app15169332"
			dbCreate = "update"
			host = "linus.mongohq.com"
			port = 10001
			username = "emote-app"
			password = "Emote-101"	
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
