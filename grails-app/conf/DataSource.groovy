grails {
	mongo {
		databaseName = "app14660500"
		dbCreate = "update"
		host = "linus.mongohq.com"
		port = 10081
		username = "emote-app"
		password = "Emote-101"


	}
  }

// environment specific settings
environments {
	development {
		mongo {
			dbCreate = "update"

		}
	}
	test {
		mongo {
			dbCreate = "update"

		}
	}
	production {
		mongo {
		}
	}
}
