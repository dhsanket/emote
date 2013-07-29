	    	<g:if test="${flash.page > 0 }">
    			<%
					def pParams = [:]
					flash.extraParams.each{k, v ->
						pParams.put(k,v)
					}
					pParams.put('page', flash.page-1) 
    			%>
	    		<div class="feedPagination clearfix">
	    			<g:link class="feedPagination buttonPrev" controller="emote" action="${flash.action}" params="${pParams}">Previous</g:link>
	    		</div>
	    	</g:if>
