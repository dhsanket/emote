package emote

class EmoteTagLib {
    static namespace = 'emoteapp'

    def UserAgentIdentService

    /**
     * @attr popularEmotesList REQUIRED Popular emotes list
     * @attr completeTitle REQUIRED Complete title
     */
    def facebookpost = { attrs ->

        def popularEmotesList = attrs.popularEmotesList
        def completeTitle = attrs.completeTitle

//        if(isMobile()){
//           def device = "touch"
//        } else {device = "page"}

        def emotes = popularEmotesList.expression.join(', ')

        out << """
         data-picture="http://www.emote-app.com/img/emote-defaultLogo.png" data-name="#$completeTitle" data-link="www.emote-app.com/zen/$completeTitle" data-description="emote-app users think #$completeTitle is $emotes" data-display="touch" data-callback="facebookPublishCallbackFunction"
         """
    }
}