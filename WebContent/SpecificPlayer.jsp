<%@ page import="model.bean.SoccerPlayerBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
    import="model.bean.*"
%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.ConverterJavaToJSUtil" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.FormatQueryDatas" %>

<% SoccerPlayerBean player = (SoccerPlayerBean) request.getAttribute("player");
    ArrayList<SkillBean> skills = (ArrayList<SkillBean>) request.getAttribute("skills");
    ArrayList<SoccerPlayerBean> relatedPlayers = (ArrayList<SoccerPlayerBean>) request.getAttribute("relatedPlayers");
    if (player == null || skills == null || relatedPlayers == null) {
        response.sendRedirect("./Index.jsp");
        return;
    }

    if (player.getName().equals("\"playing-style\"")) {
        player.setName("Manuel Neuer"); // workaround for peter neuer
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <jsp:include page="./parts/head.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="./styles/specificPlayer.css">
</head>

<body>

<jsp:include page="./parts/header.jsp" />

<div class="container_cover"></div>
<div class="container_image_player">
    <div class="image_player">
        <style>
            .image_player {
                background-image: url("<%= player.getThumbnail() %>");
            }
        </style>
    </div>
</div>
<div class="container">
    <p><%= player.getComment() %></p>
    <div class="row">
        <div class="col-lg-6">
            <p><b>Squadra attuale:</b> <a href="<%= player.getFootballTeamBean().getUri() %>" target="_blank"><%= player.getFootballTeamBean().getName()%></a></p>
        </div>
        <div class="col-lg-6">
            <p><b>Posizione:</b> <%= player.getPosition() %></p>
        </div>
    </div>
    <h3 class="margin-25">Abilità speciali di <%= player.getName() %></h3>
    <div class="row">
        <%
        for(SkillBean skill : skills) {
            %>
        <div class="col-lg-6">
            <p><b><%= skill.getNome() %></b> <a href="http://localhost:8080/SkillsFootballOntology#<%= skill.getNome() %>"><i class="fa-solid fa-arrow-up-right-from-square"></i></a>: <%= skill.getDescrizione() %></p>
        </div>
        <%
        }
        %>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-lg-6">
            <div>
                <canvas id="radarSkills"></canvas>
            </div>
            <script>
                <%  // conversion arrays from java to js
                    ArrayList<String> skillNames = new ArrayList<String>();
                    Integer[] skillValues=new Integer[0];

                    for (SkillBean skill : player.getSkills()) {
                        skillNames.add(skill.getNome());
                        List<Integer> list = new ArrayList<>(Arrays.asList(skillValues));
                        list.add(skill.getValSkill());
                        skillValues = list.toArray(new Integer[0]);
                    }

                    String arrJSLabels = ConverterJavaToJSUtil.getArrayString(skillNames);
                    String arrJSdata = ConverterJavaToJSUtil.getArrayInt(skillValues);
                %>
                const data = {
                    labels: <%= arrJSLabels %>,
                    datasets: [{
                        label: "Skills  <%= player.getName() %>",
                        data: <%= arrJSdata %>,
                        fill: true,
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgb(255, 99, 132)',
                        pointBackgroundColor: 'rgb(255, 99, 132)',
                        pointBorderColor: '#fff',
                        pointHoverBackgroundColor: '#fff',
                        pointHoverBorderColor: 'rgb(255, 99, 132)'
                    }]
                };

                console.log(data);

                const config = {
                    type: 'radar',
                    data: data,
                    options: {
                        elements: {
                            line: {
                                borderWidth: 3
                            }
                        }
                    },
                };

                const myChart = new Chart(
                    document.getElementById('radarSkills'),
                    config
                );
            </script>
        </div>
        <div class="col-lg-6">
            <table class="table table-striped table-hover">
                <tr>
                    <th>Skill</th>
                    <th>Valore</th>
                </tr>
                <%
                    for (SkillBean skill : player.getSkills()) {
                %>
                <tr>
                    <td><a href="#<%=  skill.getUri()%>"><%= skill.getNome() %></a></td>
                    <td><%= skill.getValSkill() %></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>
</div>

<div class="container">
    <h3 class="margin-25">Calciatori correlati</h3>
    <div class="row">
    <% for (SoccerPlayerBean sp : relatedPlayers) { %>
    <div class="col-lg-4">
        <div data-uri="<%= sp.getUri() %>" class="card card_player" style="width: 15rem; height: 32rem; margin: 5rem;" data-thumb="<%= sp.getThumbnail() %>">
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
            <div class="card-body">
                <%if(sp.getOverall()>91){%><p style="color: darkgoldenrod">Questo giocatore ha vinto almeno un <a href="ServletBallonDOR">pallone d'oro</a></p>
                <%}%>
            </div>
        </div>
    </div>
    <% } %>
    </div>
</div>

<div class="container">
    <h3>Informazioni aggiuntive skill</h3>
    <table class="table table-striped table-hover">
        <tr>
            <th>Skill</th>
            <th>Tipo</th>
            <th>Descrizione</th>
        </tr>
        <%
            for (SkillBean skill : player.getSkills()) {
        %>
        <tr id="<%= skill.getUri() %>">
            <td>
                <%= skill.getNome() %>
            </td>
            <td>
                <%= skill.getTipo() %>
            </td>
            <td>
                <%= skill.getDescrizione() %>
            </td>
        </tr>
        <% } %>
    </table>
</div>


<!-- Footer -->
<jsp:include page="./parts/footer.jsp" />
<!-- Footer -->

<script src="scripts/cards.js"></script>
</body>
</html>