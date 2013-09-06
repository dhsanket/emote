<div id="flag_container" class="popupzen" style="position:static;">
    <div  style="width: 100%;height:100%;overflow: scroll;position:fixed;left:0px;top:30px;z-index:19;background-color:black;margin-top: 20px;">
        <div id="fullscreen-dialog">
        <form id="flag_form" action="/flag/save">
            <div style="color: #f5f5f5">Reporting for : <span id="flag_title_display"></span></div>
            <input type="hidden" name="title" id="flag_title_hidden"/>
            <select id="flag_type_select" name="type">
                <option value="1"> Pictures are offensive </option>
                <option value="2"> emotes are offensive </option>
                <option value="3"> Other - Provide details below </option>
            </select><br>
            <textarea name="comment" id="flag_comment_text"></textarea>
            <div>
                <input type="submit" value="Submit" id="flag_submit"/>
                <button value="Close" type="button" onclick="$('#flag_container').toggleClass('active');">Close</button>
            </div>
        </form>
        </div>
    </div>
</div>