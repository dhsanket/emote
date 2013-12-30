package emote

class EmoteTagLib {
    static namespace = 'emoteapp'

    def UserAgentIdentService

    def facebookpost = { attrs ->

        def popularEmotesList = attrs.popularEmotesList
//        if(isMobile()){
//           def device = "touch"
//        } else {device = "page"}

        def emotesText = new StringBuffer("")
        popularEmotesList.expression.each{ emote ->
            emotesText << emote
        }

        def emotes = emotesText.toString()

        out << """
         <a class="fb-sdk-publish-link" href="#" data-picture="http://www.emote-app.com/img/emote-defaultLogo.png" data-name="#\${title.completeTitle}" data-link="www.emote-app.com/zen/\${title.completeTitle}" data-description="emote-app users think #\${title.completeTitle} is \${title.popularEmotes.expression}" data-display="touch" data-callback="facebookPublishCallbackFunction"><img src="/img/share_small.png"></img>
         """
    }
}