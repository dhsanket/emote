package com.emote

import java.util.Set;
import org.springframework.web.multipart.MultipartFile

@grails.validation.Validateable
class EmoteCommand {
	
	static constraints = {
		title blank:false
//		expression blank:false	Does NOT have front end User notification
//		category blank:false     has front end error checking && User notification
	}
	
	String category;
	String expression;
	String title;
	MultipartFile photo;
	
	// crop location
	int topx
	int topy
	int bottomx
	int bottomy
	int scaledImgHeight
	int scaledImgWidth
	
	String webSearchImageURL

	
	def getExpressions(){
		return expression.split(",")
	}

	
	

	String getCategory(){
		return category; 
	}
	
	
	// todo remove
	def getPicture(){
		if(photo == null)
		log.info "no pic attached in domain object"
			return null
			
		def img = new Picture(type:photo.contentType, filename:photo.originalFilename, content:photo.bytes)
		log.info "Pic is attached in domain object"
		return img;

	}
	


}
