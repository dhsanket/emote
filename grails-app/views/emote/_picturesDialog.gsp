<g:set var="loggedInClass" value="${session.user ? 'logged' : ''}"/>

<div class="emote-v2 hidden" id="picturesDialog">
    <div class="emote-v2-header silver-gradient gradient clearfix">
        <h3 data-title>**********</h3>
        <span class="type">*******</span><span class="comments-count">*******</span>
    </div> <!-- /.emote-v2-header -->

    <div class="emote-v2-body clearfix">

        <div class="emote-v2-media" data-media-type="image" >
            %{--<r:img uri="/picture/index/${title.pictureId}" />--}%
        </div> <!-- /.emote-v2-media -->

        <div class="emote-v2-content">
            <div class="swiper-container">
                <div class="slide-indicator clearfix"></div>
                <div class="swiper-wrapper">

                    <div class="swiper-slide">
                        <div class="emote-v2-media no-media" data-media-type="image" ></div>
                    </div> <!-- /.swiper-slide -->


                </div> <!-- /.swiper-wrapper -->
            </div> <!-- /.swiper-container -->
        </div> <!-- /.emote-v2-content -->
    </div>  <!-- /.emote-v2-body -->

    <div class="emote-v2-footer silver-gradient gradient clearfix">
    </div> <!-- /emote-v2-footer -->
</div> <!-- /.emote-v2 -->