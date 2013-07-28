    		<g:if test="${flash.morePages}">
    			<%
					def nParams = [:]
					flash.extraParams.each{k, v ->
						nParams.put(k,v)
					}
					nParams.put('page', flash.page+1) 
    			%>
	    		<div class="feedPagination clearfix">
					<g:link  controller="emote" action="${flash.action}" params="${nParams}">Next</g:link>
				</div>
			</g:if>
