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
    <div data-uri="<%= sp.getUri() %>" class="card card_player" style="width: 15rem; height: 36rem; margin: 5rem;" data-thumb="<%= sp.getThumbnail() %>">
      <img class="card-img-top" src="<%=sp.getThumbnail()%>" alt="Card image cap">
      <img src="./img/sample-soccer-player.png" class="card-img-top img_sample" style="display: none;">
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

<div class="container" style="margin-top: 50px">
    <h2> Le migliori squadre di calcio</h2>
  <div class="row">
    <%
      for (FootBallTeamBean ft : dao.doRetrieveStatsFootballTeamWithMaxAvgAndMinimunOverall())
      {%>
    <div class="col-lg-4">
      <div class="card card_team" style="width: 15rem; height: 28rem; margin: 5rem;" data-thumb="<%= ft.getThumbnail() %>">
        <img class="card-img-top" src="<%= ft.getThumbnail() %>" alt="Card image cap">
        <img src="./img/sample-logo-team.png" class="card-img-top img_sample" style="display: none;">
        <div class="card-body">
          <h5 class="card-title"><%=ft.getName()%></h5>
          <p class="card-text">Media overall : <%=ft.getAvg_overall()%></p>
        </div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item"> Overall max : <%=ft.getMax_overall()%></li>
          <li class="list-group-item"> Overall min  : <%=ft.getMin_overall()%></li>
        </ul>
      </div>
    </div>
    <%}%>
  </div>
  </div>


  <div class="container">
    <h2>Info skill speciali</h2>

    <table class="table table-striped table-hover">
      <tr>
        <th>Nome</th>
        <th>Tipo</th>
        <th>Descrizione</th>
        <th >Calciatori che posseggono la skill</th>
      </tr>
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
        <td><%=sp.getNome()%></td>
        <td><%=sp.getTipo()%></td>
        <td><%=sp.getDescrizione()%></td>
        <td>
          <%for(int index = 0; index< calciatori.size();index ++) {%>
          <a href="SpecificPlayer?player=<%=uri.get(index)%>"><%=calciatori.get(index)%>></a>
          <%}%>
        </td>
      </tr>
      <%}%>

    </table>


    <table class="table table-striped" style="margin: 10%;">
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

<script src="scripts/cards.js"></script>
</body>
</html>