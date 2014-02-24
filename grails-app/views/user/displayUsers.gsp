<html>
    <head>
	<title>emote-app follow page</title>


    </head>
    <body>
    	<g:render template="/common/header" />
%{--<g:render template="/common/signin_header"></g:render>--}%
    	<g:render template="/common/create_emote" />
		<g:render template="/common/menu_bar" />
    	<div id="feed-container" class="feed-container">
            <div id="followUsers">
                <g:each in="${userFriends}" var="friend">
                    <div class="user-section">
                        <span class="user-image">
                            <facebook:picture facebookId="${friend.id}" linkEnabled="true" />
                        </span>

                        <span class="user-name">${friend.name}</span>

                        <g:set var="statusMap" value="${actions[friend.id]}"/>

                        <span class="followButton">
                        <g:if test="${statusMap.status == 'invite'}">
                            <facebook:sendLink to="${friend.id}" name="Emoting Emote" description="I am using this cool new app for reviews and I think you should try it" link="www.emote-app.com" picture="http://www.emote-app.com/img/emote-defaultLogo.png">
                                invite</facebook:sendLink>
                        </g:if>
                        <g:elseif test="${statusMap.status == 'follow'}">
                            <a href="javascript:followUser('${friend.id}')"> follow </a>
                        </g:elseif>
                        <g:else>
                            <span class="label label-info">following</span>
                        </g:else>
                        </span>
                    </div>
                </g:each>
            </div>
    	</div>
    	
    	
    	
    </body>
    
</html>