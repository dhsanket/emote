<div class="popupzen" id="imgchooserpopup" style="position:static;">
    <div style="width: 100%;overflow: hidden;height:100%;position:fixed;left:0px;top:30px;z-index:19;background-color:black;padding:25%">
        <div class="error"></div>
        <button value="Web">Web</button>
        <input type="file" id="pic" name="photo" title="Device" onclick="this.value = null;" onchange="fileSelectHandler()" >
        <button value="Done" class="done-button" >Done</button>
        <button value="Cancel" class="cancel-button" >Cancel</button>
    </div>
</div>