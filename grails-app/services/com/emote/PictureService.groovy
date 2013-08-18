package com.emote

import java.awt.image.BufferedImage
import org.springframework.web.multipart.MultipartFile
import pl.burningice.plugins.image.BurningImageService
import javax.imageio.ImageIO

class PictureService {
	 BurningImageService burningImageService;
	 
	 def tempDir = System.properties.getAt("java.io.tmpdir")
	
	def crop(MultipartFile image, int topX, int topY, int bottomX, int bottomY, int scrWidth, int scrHeight){
		BufferedImage bi = ImageIO.read(image.getInputStream());
		Integer width = bi.getWidth();
		Integer height = bi.getHeight();
		
		int xScaling = width/scrWidth
		int yScaling = height/scrHeight
		topX = topX*xScaling
		bottomX = bottomX*xScaling - topX
		topY = topY*yScaling 
		bottomY = bottomY*yScaling - topY
		
		log.info("crop cordinates ($topX, $topY) ($bottomX, $bottomY) scale ratio ($xScaling, $yScaling), "
						+"screen ($scrWidth, $scrHeight)")
		burningImageService.doWith(image, tempDir).execute(){
			it.crop(topX, topY, bottomX, bottomY)
		}
		File croppedFile = new File(tempDir+File.separator+image.originalFilename)
		byte [] croppedContent = croppedFile.readBytes()
		Picture img = new Picture(type:image.contentType, filename:image.originalFilename, content:croppedContent)
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
