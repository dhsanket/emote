package com.emote

import org.springframework.web.multipart.MultipartFile

class PictureService {
	 def burningImageService;
	 
	 def tempDir = System.properties.getAt("java.io.tmpdir")
	
	def crop(MultipartFile image, int topX, int topY, int bottomX, int bottomY){
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
