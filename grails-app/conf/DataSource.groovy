grails {
	mongo {
		databaseName = "app14660500"
		dbCreate = "update"
		host = "linus.mongohq.com"
		port = 10081

	}
  }

// environment specific settings
environments {
	development {
		mongo {
			dbCreate = "update"
			host = "linus.mongohq.com"
			port = 10081

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
