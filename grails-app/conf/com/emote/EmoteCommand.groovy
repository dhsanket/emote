package com.emote

import java.util.Set;

@grails.validation.Validateable	
class EmoteCommand {
	
	static constraints = {
		title blank:false
		topic blank:false 
		expression blank:false
	}
	
	String topic;
	String expression;
	String title;
  
	def getTopics(){
		return topic.split("/")
	}
	
	def getExpressions(){
		return expression.split("\\\\")
	}

}
