<html>
    <head>
    </head>
    <body>
     <div class="friends grid_20">
	      <div class="btn-group">
			<g:if test="${fbFriends != null}">
				<g:each in="${fbFriends}" var="friend">
	                 <legend>${friend.name} 
	                  <a class="btn btn-info"> <i class="icon-user"></i> <i class="icon-question-sign"> </i> </a>
	                </legend>
				
				</g:each>				
			</g:if>
			<g:else>
			   <div class="btn btn-info">Unable to get facebook friends</div>
			</g:else>
	     </div>
     </div>
    </body>
</html>