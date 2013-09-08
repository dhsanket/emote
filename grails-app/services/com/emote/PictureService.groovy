package com.emote

import java.awt.image.BufferedImage
import org.apache.http.HttpEntity
import org.springframework.web.multipart.MultipartFile
import pl.burningice.plugins.image.BurningImageService
import javax.imageio.ImageIO

import groovyx.net.http.*
import static groovyx.net.http.ContentType.ANY
import static groovyx.net.http.Method.GET


class PictureService {
	 BurningImageService burningImageService;
	 
	 def tempDir = System.properties.getAt("java.io.tmpdir")
	
	def crop(MultipartFile image, int topX, int topY, int bottomX, int bottomY, int scrWidth, int scrHeight){
		log.info " got image of type $image.contentType, $image.originalFilename"
		return crop(image.inputStream, image.contentType, image.originalFilename, topX, topY, bottomX, bottomY, scrWidth, scrHeight)
	}
	
	def crop(String webUrl, int topX, int topY, int bottomX, int bottomY, int scrWidth, int scrHeight){
		def http = new HTTPBuilder(webUrl)
	   // perform a GET request, expecting response data
	   http.request( GET, ANY ) {
		 // response handler for a success response code:
		 response.success = { resp ->
		   HttpEntity entity = resp.entity
		   return crop(entity.content,  entity.contentType.value, "web-img", topX, topY, bottomX, bottomY, scrWidth, scrHeight)
		 }
		
		 // handler for any failure status code:
		 response.failure = { resp ->
		   log.error "Unexpected error: ${resp.status} : ${resp.statusLine.reasonPhrase}"
		 }
	   }
	}
	
	
	Picture crop(InputStream fileStream, String type, String fileName, int topX, int topY, int bottomX, int bottomY, int scrWidth, int scrHeight){
		def fos= new FileOutputStream(tempDir+"/"+fileName)
		fos.write(fileStream.getBytes())
		fos.flush()
		fos.close()
		log.info("file saved at location"+ tempDir+"/"+fileName )

			
		BufferedImage bi = ImageIO.read(new File(tempDir+"/"+fileName));
		Integer width = bi.getWidth();
		Integer height = bi.getHeight();
		double xScaling = width/scrWidth
		double yScaling = height/scrHeight
		topX = topX*xScaling
		bottomX = bottomX*xScaling - topX
		topY = topY*yScaling
		bottomY = bottomY*yScaling - topY
		
	
		log.info("crop cordinates ($topX, $topY) ($bottomX, $bottomY) scale ratio ($xScaling, $yScaling), "
						+"screen ($scrWidth, $scrHeight) image width height ($width, $height)")
		burningImageService.doWith(tempDir+"/"+fileName, tempDir).execute(){
			it.crop(topX, topY, bottomX, bottomY)
		}
		File croppedFile = new File(tempDir+File.separator+fileName)
		byte [] croppedContent = croppedFile.readBytes()
		Picture img = new Picture(type:type, filename:fileName, content:croppedContent)
		croppedFile.delete()
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
