    		<g:if test="${flash.morePages}">
    			<%
					def nParams = [:]
					flash.extraParams.each{k, v ->
						nParams.put(k,v)
					}
					nParams.put('page', flash.page+1) 
    			%>
	    		<div class="feedPagination clearfix">
					<g:link class="buttonNext" controller="emote" action="${flash.action}" params="${nParams}" onClick="_gaq.push(['_trackEvent', 'Feed page', 'Reads feed page', 'Feed page next page click', 1, false]);"> see more... </g:link>
				</div>
			</g:if>
