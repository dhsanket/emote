package com.emote

@grails.validation.Validateable
class EmoteCommand {
	
	static constraints = {
		title blank:false
        doingNow nullable: true
//		expression blank:false	Does NOT have front end User notification
//		category blank:false     has front end error checking && User notification
	}
	
	String category;
	String expression;
    String goodOrBad
	String title;
    Boolean doingNow

	def getExpressions(){
		return expression.split(",")
	}

    def getGoodOrBads(){
        def goodOrBad = populateTempGoodOrBads() // todo this line should be removed after we change the UI to send proper data
        goodOrBad.split(",")
    }

    // todo this line should be removed after we change the UI to send proper data
	def populateTempGoodOrBads ={
        String fake =""
        expressions.each{
            fake = fake +"unsure,"
        }
        if(fake.length()>0){
            fake= fake.substring(0, fake.length())
        }
        fake
    }
	

	String getCategory(){
		return category; 
	}

}
