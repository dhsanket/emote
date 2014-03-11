<header>
    <div class="clearfix">
        <g:link controller="emote" action="feed" ><h1 id="logo" class="pull-left"></h1></g:link>
        <a href="#" id="toggleMenu" class="header-icon pull-left"><r:img uri="img/menu-icon.png" alt="menu"/></a>

        <g:if test="${session.user}">
            <a href="#" id="createEmote" class="header-icon pull-right"><r:img uri="img/create-emote.png" alt="Create Emote"/></a>
        </g:if>
        <a href="#" id="searchIcon" class="header-icon pull-right"><i class="icon icon-search icon-white"></i></a>
    </div>
    <g:if test="${session.user == null}">
        <g:render template="/common/signin_header_emote"></g:render>
    </g:if>
</header>