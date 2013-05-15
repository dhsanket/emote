<html>
    <head>

    </head>
    <body>
    <div class="item-section grid_23 omega">
        <div class="grid_22 emote-howto">
          <g:form action="save" controller="emote">
            <fieldset>
              <legend>Create your emote\o/ below...</legend>
			  <g:renderErrors bean="${emote}"/>	
              <label>Item-title is the specific subject/item you want share an emote about</label>
              <div class='value ${hasErrors(bean:emote,field:'title','errors')}'>
              		<g:textField name="title" placeholder="Item-title " value="${fieldValue(bean:emote,field:'title')}"/>
              </div>
              <span class="help-block"></span>

              <label>  emotes are adjectives which highlight qualities of the things you experience <br> </label>
              <div class='value ${hasErrors(bean:emote,field:'expression','errors')}'>
              	<g:textField name="expression" placeholder="\\amazing \\unpredictable..." value="${fieldValue(bean:emote,field:'expression')}"/>
              </div>
              <%--<span class="help-block">("\" each emote goes after a back slash) </span>--%>

              <label> Topic('s) </label>
              <div class='value ${hasErrors(bean:emote,field:'topic','errors')}'>
             	 <g:textField name="topic" placeholder="/movie /cricket" value="${fieldValue(bean:emote,field:'topic')}"/>
              </div>
              <%--<span class="help-block"> ("/" each topic key word goes after a forward slash)</span>--%>
              <br>
              <g:submitButton class="btn btn-large grid_15" name="emote\\o/"/>
            </fieldset>
          </g:form>
       </div>
	</div>
    </body>
    
</html>