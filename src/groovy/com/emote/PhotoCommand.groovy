package com.emote

import org.springframework.web.multipart.MultipartFile

class PhotoCommand {

    String title

    MultipartFile photo;
    // crop location
    double topx
    double topy
    double bottomx
    double bottomy
    double scaledImgHeight
    double scaledImgWidth

    String webSearchImageURL

    int getTopxInt() {
        Math.round(topx)
    }

    int getTopyInt() {
        Math.round(topy)
    }

    void setBottomx(double bottomx) {
        this.bottomx = bottomx
    }

    int getBottomxInt() {
        Math.round(bottomx)
    }

    void setBottomy(double bottomy) {
        this.bottomy = bottomy
    }

    int getBottomyInt() {
        Math.round(bottomy)
    }

    int getScaledImgHeightInt() {
        Math.round(scaledImgHeight)
    }

    int getScaledImgWidthInt() {
        Math.round(scaledImgWidth)
    }
}