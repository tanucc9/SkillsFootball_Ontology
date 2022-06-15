<%@ page import="model.bean.SoccerPlayerBean" %>
<%@ page import="model.dao.SkillsFootballOntologyDAO" %>
<%@ page import="model.bean.FootBallTeamBean" %>
<%@ page import="model.bean.SkillBean" %>
<%@ page import="java.util.ArrayList" %>
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

<div class="container">

  <div class="accordion" id="accordion-sfo">
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          <h3>I migliori calciatori</h3>
        </button>
      </h2>
      <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne">
        <div class="accordion-body">
          <div class="row">
            <%
              SkillsFootballOntologyDAO dao = new SkillsFootballOntologyDAO();

              ArrayList<SoccerPlayerBean> players = dao.doRetrieveBest30SoccerPlayerInTheWorld();
              if (players != null) {
                for (SoccerPlayerBean sp : players)
                {
                  if (!sp.getName().equals("\"playing-style\"")) {
            %>
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
                  <%if(dao.hasPlayerWonBallonDor("<" + sp.getUri() + ">")){%><p style="color: darkgoldenrod">Questo giocatore ha vinto almeno un <a href="ServletBallonDOR">pallone d'oro</a></p>
                  <%}%>
                </div>
              </div>
            </div>
            <%}}}%>
          </div>
        </div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingTwo">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          <h3>Le migliori squadre di calcio</h3>
        </button>
      </h2>
      <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo">
        <div class="accordion-body">
          <%
            ArrayList<FootBallTeamBean> teams = dao.doRetrieveStatsFootballTeamWithMaxAvgAndMinimunOverall();
            if (teams != null) { %>
          <div class="row">
            <%
              for (FootBallTeamBean ft : teams)
              {%>
            <div class="col-lg-4">
              <div class="card card_team" style="width: 15rem; height: 28rem; margin: 5rem;" data-thumb="<%= ft.getThumbnail() %>">
                <img class="card-img-top" src="<%= ft.getThumbnail() %>" alt="Card image cap">
                <img src="./img/sample-logo-team.png" class="card-img-top img_sample" style="display: none;">
                <div class="card-body">
                  <h5 class="card-title">
                    <%=ft.getName()%>
                    <a href="<%= ft.getUri() %>" target="_blank">
                      <i class="fa-solid fa-arrow-up-right-from-square"></i>
                    </a>
                  </h5>
                  <p class="card-text">Media overall : <%=ft.getAvg_overall()%></p>
                </div>
                <ul class="list-group list-group-flush">
                  <li class="list-group-item"> Overall max : <%=ft.getMax_overall()%></li>
                  <li class="list-group-item"> Overall min  : <%=ft.getMin_overall()%></li>
                </ul>
              </div>
            </div>
            <%}}%>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

  <div class="container">
    <h3>Info skill speciali</h3>

    <table class="table table-striped table-hover">
      <%
        ArrayList<SkillBean> specialSkills = dao.doRetrieveSpecialSkillsWithNameAndResourceSoccerPlayer();
        if (specialSkills != null) { %>

      <tr>
        <th>Nome</th>
        <th>Tipo</th>
        <th>Descrizione</th>
        <th >Calciatori che posseggono la skill</th>
      </tr>

      <%
        for (SkillBean skill : specialSkills)
        {
          ArrayList<String> calciatori = new ArrayList<>();
          ArrayList<String> uri = new ArrayList<>();
          for(SoccerPlayerBean sc : skill.getPlayers()){
            calciatori.add(sc.getName());
            uri.add(sc.getUri());
          }
      %>
      <tr id="<%= skill.getNome() %>">
        <td><%=skill.getNome()%></td>
        <td><%=skill.getTipo()%></td>
        <td><%=skill.getDescrizione()%></td>
        <td>
          <%for(int index = 0; index< calciatori.size();index ++) {%>
          <a href="SpecificPlayer?player=<%=uri.get(index)%>"><%=calciatori.get(index)%></a>,
          <%}%>
        </td>
      </tr>
      <%}}%>

    </table>
  </div>

<!-- Footer -->
<jsp:include page="./parts/footer.jsp" />
<!-- Footer -->

<script src="scripts/cards.js"></script>
</body>
</html>