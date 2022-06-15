<%@ page import="model.bean.SoccerPlayerBean" %>
<%@ page import="model.dao.SkillsFootballOntologyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="it">
<head>
    <jsp:include page="./parts/head.jsp" />
    <link rel="stylesheet" href="./styles/home.css">
</head>

<body>

<jsp:include page="./parts/header.jsp" />

<%SkillsFootballOntologyDAO dao = new SkillsFootballOntologyDAO();

    String commento1 = dao.doRetrieveBallonDOr().get(0).getComment_BallonDOr();
    String commento2 = dao.doRetrieveBallonDOr().get(0).getLabel_BallonDOr();
%>

<div class="container" style="margin-top: 50px">
<div class = row>
    <div class="column">
        <h2><%=commento2%></h2>
        <p><%=commento1%></p>
    </div>
</div>
<div class="row">
    <%
        for (SoccerPlayerBean sp : dao.doRetrieveBallonDOr())
        {%>
    <div class="col-lg-6">
        <div data-uri="<%= sp.getUri() %>" class="card card_player" style="width: 15rem; height: 36rem; margin: 5rem;" data-thumb="<%= sp.getThumbnail() %>">
            <img class="card-img-top" src="<%=sp.getThumbnail()%>" alt="Card image cap">
            <img src="./img/sample-soccer-player.png" class="card-img-top img_sample" style="display: none;">
            <div class="card-body">
                <h5 class="card-title"><%=sp.getName()%></h5>
                <p class="card-text"><%=sp.getFootballTeamBean().getName()%></p>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">Overall : <%=sp.getOverall()%></li>
                <li class="list-group-item">Ruolo : <%=sp.getPosition()%></li>
            </ul>
        </div>
    </div>
    <%}%>
</div>
</div>

<!-- Footer -->
<jsp:include page="./parts/footer.jsp" />
<!-- Footer -->

<script src="scripts/cards.js"></script>
</body>
</html>