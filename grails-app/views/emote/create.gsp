<html>
    <head>

    </head>
    <body>
        <div class="grid_22 emote-howto">
          <g:form action="create" controller="emote">
            <fieldset>
              <legend>Create your emote\o/ below...</legend>

              <label>Item title needs to be in between quotes</label>
              <g:textField name="title" placeholder=" 'Title' "/>
              <span class="help-block"></span>

              <label>  "\" each emote goes after a back slash <br> </label>
              <g:textField name="expression" placeholder="\\amazing \\unpredictable..." />
              <span class="help-block">(emotes are adjectives which highlight qualities of the things you experience \o/) </span>

              <label> "/" each topic key word goes after a forward slash </label>
              <g:textField name="topic" placeholder="/movie /thriller /big budget..." />
              <span class="help-block"></span>
              <br>
              <label class="checkbox pull-left">
                <input type="checkbox"> Append location
              </label>
              <br>
              <br>
              <g:submitButton class="btn btn-large grid_15" name="Shout your emote!"/>
            </fieldset>
          </g:form>
       </div>

    </body>
    
</html>