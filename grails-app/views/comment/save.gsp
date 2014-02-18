<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="none"/>
    </head>

    <body>
        <g:if test="${comment.parentCommentId}">

        </g:if>
        <g:else>
            <g:render template="/common/comment/rootComment" model="[comment: comment]"/>
        </g:else>
    </body>
</html>