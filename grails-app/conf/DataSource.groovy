grails {
	mongo {
	  databaseName = "emote"
	}
  }

// environment specific settings
environments {
	development {
		mongo {
			dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
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
			dbCreate = "update"
			databaseName = "app14660500"
			host = "linus.mongohq.com"
			port = 10081
		}
	}
}
