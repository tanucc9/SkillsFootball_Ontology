<%@ page import="model.bean.SoccerPlayerBean" %>
<%@ page import="model.dao.SkillsFootballOntologyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="it">
<head>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        /* Float four columns side by side */
        .column {
            float: left;
            width: 25%;
            padding: 0 10px;
        }

        /* Remove extra left and right margins, due to padding in columns */
        .row {margin: 0 -5px;}

        /* Clear floats after the columns */
        .row:after {
            content: "";
            display: table;
            clear: both;
        }

        /* Style the counter cards */
        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* this adds the "card" effect */
            padding: 16px;
            text-align: center;
            background-color: #f1f1f1;
        }

        /* Responsive columns - one column layout (vertical) on small screens */
        @media screen and (max-width: 600px) {
            .column {
                width: 100%;
                display: block;
                margin-bottom: 20px;
            }
        }
    </style>
    <jsp:include page="./parts/head.jsp" />
</head>

<body>

<jsp:include page="./parts/header.jsp" />

<%SkillsFootballOntologyDAO dao = new SkillsFootballOntologyDAO();

    String commento1 = dao.doRetrieveBallonDOr().get(0).getComment_BallonDOr();
    String commento2 = dao.doRetrieveBallonDOr().get(0).getLabel_BallonDOr();
%>
<div class = row>
    <div class="column">
        <p><h2><%=commento2%></h2></p>
        <p><h4><%=commento1 + "\n Questi gli unici due calciaotri presenti attualmente ad aver vinto questo prestigioso riconoscimento"%></h4></p>
    </div>
</div>
<div class="row">
    <%
        for (SoccerPlayerBean sp : dao.doRetrieveBallonDOr())
        {%>
    <div class="column">
        <div class="card" style="width: 15rem; height: 40rem; margin: 5rem;">
            <img class="card-img-top" src="<%=sp.getThumbnail()%>" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title"><%=sp.getName()%></h5>
                <p class="card-text"><%=sp.getFottballTeamBean().getName()%></p>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">Overall : <%=sp.getOverall()%></li>
                <li class="list-group-item">Ruolo : <%=sp.getPosition()%></li>

            </ul>
            <div class="card-body">
                <p><a href="SpecificPlayer?player=<%=sp.getUri()%>" class="card-link">Caratteristiche Giocatore</a></p>
            </div>
        </div>
    </div>
    <%}%>
</div>

<!-- Footer -->
<jsp:include page="./parts/footer.jsp" />
<!-- Footer -->

</body>
</html>