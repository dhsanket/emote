<span <g:each in="${attrs}" var="attr">${attr.key}="${attr.value}" </g:each> title="<g:formatDate date="${timestamp}" format="${message(code: 'friendly.time.timestamp.formatter.label')}"/>">
    <g:message code="${formatterKey}" args="[periodVal]"/>
</span>