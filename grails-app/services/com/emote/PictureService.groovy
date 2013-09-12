package com.emote

import java.awt.image.BufferedImage
import java.awt.image.DataBufferByte
import org.apache.http.HttpEntity
import org.springframework.web.multipart.MultipartFile

import javax.imageio.ImageIO

import groovyx.net.http.*
import static groovyx.net.http.ContentType.ANY
import static groovyx.net.http.Method.GET


class PictureService {
	 
	 def tempDir = System.properties.getAt("java.io.tmpdir")
	
	def crop(MultipartFile image, int topX, int topY, int bottomX, int bottomY, int scrWidth, int scrHeight){
		log.info " got image of type $image.contentType, $image.originalFilename"
		return crop(image.inputStream, image.contentType, System.currentTimeMillis()+image.originalFilename, topX, topY, bottomX, bottomY, scrWidth, scrHeight)
	}
	
	def crop(String webUrl, int topX, int topY, int bottomX, int bottomY, int scrWidth, int scrHeight){
		def http = new HTTPBuilder(webUrl)
	   // perform a GET request, expecting response data
	   http.request( GET, ANY ) {
		 // response handler for a success response code:
		 response.success = { resp ->
		   HttpEntity entity = resp.entity
		   return crop(entity.content,  entity.contentType.value, ""+System.currentTimeMillis(), topX, topY, bottomX, bottomY, scrWidth, scrHeight)
		 }
		
		 // handler for any failure status code:
		 response.failure = { resp ->
		   log.error "Unexpected error: ${resp.status} : ${resp.statusLine.reasonPhrase}"
		 }
	   }
	}
	
	
	Picture crop(InputStream fileStream, String type, String fileName, int topX, int topY, int cropWidth, int cropHeight, int scrWidth, int scrHeight){
		BufferedImage bi = ImageIO.read(fileStream);
		Integer width = bi.getWidth();
		Integer height = bi.getHeight();
		
		double xScaling = width/scrWidth
		double yScaling = height/scrHeight
		topX = topX*xScaling
		cropWidth = cropWidth*xScaling - topX
		topY = topY*yScaling
		cropHeight = cropHeight*yScaling - topY

		log.info("crop cordinates ($topX, $topY) ($cropWidth, $cropHeight) scale ratio ($xScaling, $yScaling), "
			+"screen ($scrWidth, $scrHeight) image width height ($width, $height)")
		File imFile = new File(tempDir+File.separator+fileName)
		BufferedImage cropped = bi.getSubimage(topX, topY, cropWidth, cropHeight)
		log.info("cropped size is $cropped.width  $cropped.height")
		ImageIO.write(cropped, "jpeg", imFile)
		byte [] croppedContent =  imFile.readBytes()
		Picture img = new Picture(type:type, filename:fileName, content:croppedContent)
		imFile.delete()
		return img
		
	}



    def getImage(String id) {
		return Picture.findById(id)
    }
	
	def store(Picture image){
		image.save()
		log.info "saved image of size $image.content.length and id = $image.id type= $image.type"
		return image.id
	}
}
