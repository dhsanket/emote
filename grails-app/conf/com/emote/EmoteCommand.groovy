package com.emote

import java.util.Set;
import org.springframework.web.multipart.MultipartFile

@grails.validation.Validateable
class EmoteCommand {
	
	static constraints = {
		title blank:false
		expression blank:false
	}
	
	String category;
	String expression;
	String title;
	MultipartFile photo;
	

	
	def getExpressions(){
		return expression.split(",")
	}

	
	

	String getCategory(){
		return category; 
	}
	
	
	def getPicture(){
		if(photo == null)
			return null
		def img = new Picture(type:photo.contentType, filename:photo.originalFilename, content:photo.bytes)
		return img;

	}
	


}
