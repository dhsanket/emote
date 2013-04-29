<html>
    <head>

    </head>
    <body>
    <div class="item-section grid_23 omega">
        <div class="grid_22 emote-howto">
          <g:form action="save" controller="emote">
            <fieldset>
              <legend>Create your emote\o/ below...</legend>

              <label>Item-title is the specific subject/item you want share an emote about</label>
              <g:textField name="title" placeholder="Item-title "/>
              <span class="help-block"></span>

              <label>  emotes are adjectives which highlight qualities of the things you experience <br> </label>
              <g:textField name="expression" placeholder="\\amazing \\unpredictable..." />
              <%--<span class="help-block">("\" each emote goes after a back slash) </span>--%>

              <label> Topic('s) </label>
              <g:textField name="topic" placeholder="/movie /cricket" />
              <%--<span class="help-block"> ("/" each topic key word goes after a forward slash)</span>--%>
              <br>
              <g:submitButton class="btn btn-large grid_15" name="emote\\o/"/>
            </fieldset>
          </g:form>
       </div>
	</div>
    </body>
    
</html>