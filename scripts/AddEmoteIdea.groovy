import com.gmongo.GMongo
import com.mongodb.Mongo

includeTargets << grailsScript("_GrailsBootstrap")

target(main: "The description of the script goes here!") {
    depends checkVersion, configureProxy, bootstrap
    def mongo = new GMongo()
    def db = mongo.getDB(grailsApp.config.grails.mongo.databaseName)
    def emotes = db.emote.find()

    emotes.each { em ->
        em.expressions.each { exp ->
            db.emote.update([_id: em._id], [$addToSet: [expressionIdeas: [text: exp, goodOrBad: "unsure"]]])
        }
    }
}
setDefaultTarget(main)
