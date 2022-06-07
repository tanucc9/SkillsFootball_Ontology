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
      width: 33%;
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
    .fullscreen {
      position: fixed;
      top: 8%;
      left: 0;
      bottom: 0;
      right: 0;
      overflow: auto;
      background: #055db8; /* Just to visualize the extent */

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

<div class="fullscreen" class="row">
<%
  SkillsFootballOntologyDAO dao = new SkillsFootballOntologyDAO();
  int i = 0;

  for (SoccerPlayerBean sp : dao.doRetrieveBest30SoccerPlayerInTheWorld())
  {%>
<div class="column">
<div class="card" style="width: 15rem; height: 50rem; margin: 5rem;">
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
    <%if(sp.getOverall()>91){%><p style="color: darkgoldenrod">Questo giocatore ha vinto almeno un pallone d'ora</p>
    <p><a href="ServletBallonDOR" class="card-link">Clicca qui per maggiori informazioni su questo riconoscimento!!</a></p>
    <%}%>
  </div>
</div>
</div>
<%}%><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br>
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

</body>
</html>