package emote

import org.joda.time.DateTime
import org.joda.time.Period

class EmoteTagLib {
    static namespace = 'emoteapp'

    def UserAgentIdentService

    /**
     * @attr popularEmotesList REQUIRED Popular emotes list
     * @attr completeTitle REQUIRED Complete title
     */
//    def facebookpost = { attrs ->
//
//        def popularEmotesList = attrs.popularEmotesList
//        def completeTitle = attrs.completeTitle
//
//        def emotes = popularEmotesList.expression.join(', ')
//
//        out << """
//        <li class=\"feeds-sprite feeds-share-icon last \${loggedInClass}\"  data-picture="http://www.emote-app.com/img/emote-defaultLogo.png" data-name="#$completeTitle" data-link="www.emote-app.com/zen/$completeTitle" data-display="" data-description="emote-app users think #$completeTitle is $emotes" data-callback="facebookPublishCallbackFunction" > </li>
//         """
//    }

    /**
     * @attr timestamp REQUIRED Timestamp to show
     */
    def friendlyTime = { attrs ->
        Date timestamp = attrs.remove('timestamp')

        DateTime currentDt = DateTime.now()
        DateTime timestampDt = new DateTime(timestamp)

        Period period = new Period(timestampDt, currentDt)

        String periodType = 'seconds'
        Integer periodVal = period.seconds

        if(period.years > 0) {
            periodType = 'years'
            periodVal = period.years
        } else if(period.months > 0) {
            periodType = 'months'
            periodVal = period.months
        } else if(period.weeks > 0) {
            periodType = 'weeks'
            periodVal = period.weeks
        } else if(period.days > 0) {
            periodType = 'days'
            periodVal = period.days
        } else if(period.hours > 0) {
            periodType = 'hours'
            periodVal = period.hours
        } else if(period.minutes > 0) {
            periodType = 'minutes'
            periodVal = period.minutes
        }

        out << message(code: "friendly.time.${periodType}.formatter.label", args: [periodVal])
    }
}