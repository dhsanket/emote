// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]



// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*', '/img/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']


environments {
    development {
        grails.logging.jul.usebridge = true
		//FACEBOOK http://localhost:8080  Database Heroku emote-test
		grails.plugin.facebooksdk.app.id = 498699006889199
		grails.plugin.facebooksdk.app.permissions = ['email']
		grails.plugin.facebooksdk.app.secret = '03ce9aa10c83dcbcb0bdb5dc1aa4fb4b'
		
		def FacebookAppId = 498699006889199
    }
	
	test {
		grails.logging.jul.usebridge = false
		// TODO: grails.serverURL = "http://www.changeme.com"
		
		//FACEBOOK http://emote-test.herokuapp.com  Database:Heroku emote-test
		grails.plugin.facebooksdk.app.id = 145688522291575
		grails.plugin.facebooksdk.app.permissions = ['email']
		grails.plugin.facebooksdk.app.secret = '5f07c996c6d822970b98ee25f9a5d687'
		//***git@heroku.com:emote-test.git
		//***git remote add heroku-test git@heroku.com:emote-test.git
		
		def FacebookAppId = 145688522291575
		
	}
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
		
		//FACEBOOK http://emote-app.herokuapp.com  Database:Heroku emote-app
		grails.plugin.facebooksdk.app.id = 407280009364725
		grails.plugin.facebooksdk.app.permissions = ['email']
		grails.plugin.facebooksdk.app.secret = '63da47e8de8c5f5516d113e2036c50a2'
		
		def FacebookAppId = 407280009364725
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:
    //
    appenders {
        file name:'error', layout:pattern(conversionPattern: '%c{2} %m%n'), maxSize: 1024, file:"error.log",
                threshold: org.apache.log4j.Level.ERROR
        console name: 'stdout'
    }

	debug  'com.emote' // emote classes
    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
     root{
        info 'stdout'
     }
     
}
emote.error.retrieve.url=""
emote.desktopBrowser.redirect.url="landingPage.html"
emote.title.connectors = ["in"]
