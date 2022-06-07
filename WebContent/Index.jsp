<%@ page import="model.bean.SoccerPlayerBean" %>
<%@ page import="model.dao.SkillsFootballOntologyDAO" %>
<%@ page import="model.bean.FootBallTeamBean" %>
<%@ page import="model.bean.SkillBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.LoggerSingleton" %>
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
  <div class="row">
  <%
    SkillsFootballOntologyDAO dao = new SkillsFootballOntologyDAO();
    int i = 0;

    for (SoccerPlayerBean sp : dao.doRetrieveBest30SoccerPlayerInTheWorld())
    {
      if (!sp.getName().equals("\"playing-style\"")) {
  %>
  <div class="col-lg-4">
    <div data-uri="<%= sp.getUri() %>" class="card card_player" style="width: 15rem; height: 36rem; margin: 5rem;">
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
        <%if(sp.getOverall()>91){%><p style="color: darkgoldenrod">Questo giocatore ha vinto almeno un <a href="ServletBallonDOR">pallone d'oro</a></p>
        <%}%>
      </div>
    </div>
  </div>
  <%}}%>
  </div>
</div>



<br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br>
  <div  style="margin-top: 50%;">
    <p><h2 style="color: #f1f1f1">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspSquadre di calcio con la media dell'overall totale, il giocatore più forte e quello meno forte</h2></p>
    <%


      for (FootBallTeamBean sp : dao.doRetrieveStatsFootballTeamWithMaxAvgAndMinimunOverall())
      {%>
    <div class="column">
      <div class="card" style="width: 15rem; height: 40rem; margin: 5rem;">
        <img class="card-img-top" src="<%=sp.getThumbnail()%>" alt="Card image cap">
        <div class="card-body">
          <h5 class="card-title"><%=sp.getName()%></h5>
          <p class="card-text">Avg : <%=sp.getAvg_overall()%></p>
        </div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item"> max Overall : <%=sp.getMax_overall()%></li>
          <li class="list-group-item">min overall  : <%=sp.getMin_overall()%></li>
        </ul>
      </div>
    </div>
    <%}%>
  </div>
  <div  style="margin-top: 50%;">
    <p><h2 style="color: #f1f1f1">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspEcco un elenco di tutte le skill speciali del gioco</h2></p>
    <table class="table table-striped" style="margin: 10%;">
      <thead style="background-color: #f1f1f1">
      <tr>
        <th scope="col">Nome Skill</th>
        <th scope="col">Tipo Skill</th>
        <th scope="col">Descrizione Skill</th>
        <th scope="col">Calciaotri che la posseggono</th>
      </tr>
      </thead>
      <tbody>
    <%
      for (SkillBean sp : dao.doRetrieveSpecialSkillsWithNameAndResourceSoccerPlayer())
      {
        ArrayList<String> calciatori = new ArrayList<>();
        ArrayList<String> uri = new ArrayList<>();
        for(SoccerPlayerBean sc : sp.getPlayers()){
          calciatori.add(sc.getName());
          uri.add(sc.getUri());
        }




    %>
        <tr>
          <td scope="row"><%=sp.getNome()%></td>
          <td><%=sp.getTipo()%></td>
          <td><%=sp.getDescrizione()%></td>
          <td><%for(int index = 0; index< calciatori.size();index ++) {
            LoggerSingleton.getInstance().debug("\n\n"+uri.get(index));
          %> <a href="SpecificPlayer?player=<%=uri.get(index)%>"><%=calciatori.get(index)%>></a><%}%></td>
         <!-- <%// for(i=0 ; i<calciatori.size(); i++)
            %>
          <td><a href="SpecificPlayer?player=<%=uri.get(i)%>" class="card-link"><%=calciatori.get(i)%></a></td><%
          %>
         -->
        </tr>
    <%}%>
      </tbody>
    </table>
  </div>

</div>

<!-- Footer -->
<jsp:include page="./parts/footer.jsp" />
<!-- Footer -->

<script src="./scripts/click_card.js"></script>
</body>
</html>