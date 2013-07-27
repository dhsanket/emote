package com.emote

import java.util.Set;

@grails.validation.Validateable
class EmoteCommand {
	
	static constraints = {
		title blank:false
		expression blank:false
	}
	
	String topic;
	String expression;
	String title;
 

	
	def getExpressions(){
		return expression.split(",")
	}

	
	

	def getTopics(){
		if(topic == null){
			return []
		}
		return topic.split("/")
	}
	


}
