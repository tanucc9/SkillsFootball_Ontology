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
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>SkillsFootball Ontology</title>

  <!-- CSS only -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
        crossorigin="anonymous">

  <!-- JavaScript Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
          crossorigin="anonymous"></script>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Skills Football Ontology</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Lista calciatori</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Abilità calciatori</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

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
<%}%>
</div>

<!-- Footer -->
<footer class="text-center text-lg-start bg-light text-muted">
  <!-- Section: Social media -->
  <section
          class="d-flex justify-content-center justify-content-lg-between p-4 border-bottom"
  >
    <!-- Left -->
    <div class="me-5 d-none d-lg-block">
      <span>Resta connesso con noi!!!</span>
    </div>
    <!-- Left -->
  </section>
  <!-- Section: Social media -->

  <!-- Section: Links  -->
  <section class="">
    <div class="container text-center text-md-start mt-5">
      <!-- Grid row -->
      <div class="row mt-3">
        <!-- Grid column -->
        <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
          <!-- Content -->
          <h6 class="text-uppercase fw-bold mb-4">
            <i class="fas fa-gem me-3"></i>Il team
          </h6>
          <p>
            Siamo due ragazzi iscritti alla magistrale di informatica presso il Dipartimento di Informatica dell'Università degli studi di Salerno.
            Questo progetto è stato realizzato per il corso di Intelligent Web
          </p>
        </div>
        <!-- Grid column -->

        <!-- Grid column -->
        <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
          <!-- Links -->
          <h6 class="text-uppercase fw-bold mb-4">
            Products
          </h6>
          <p>
            <a href="#!" class="text-reset">Angular</a>
          </p>
          <p>
            <a href="#!" class="text-reset">React</a>
          </p>
          <p>
            <a href="#!" class="text-reset">Vue</a>
          </p>
          <p>
            <a href="#!" class="text-reset">Laravel</a>
          </p>
        </div>
        <!-- Grid column -->

        <!-- Grid column -->
        <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
          <!-- Links -->
          <h6 class="text-uppercase fw-bold mb-4">
            Useful links
          </h6>
          <p>
            <a href="#!" class="text-reset">Pricing</a>
          </p>
          <p>
            <a href="#!" class="text-reset">Settings</a>
          </p>
          <p>
            <a href="#!" class="text-reset">Orders</a>
          </p>
          <p>
            <a href="#!" class="text-reset">Help</a>
          </p>
        </div>
        <!-- Grid column -->

        <!-- Grid column -->
        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
          <!-- Links -->
          <h6 class="text-uppercase fw-bold mb-4">
            Contatti
          </h6>
          <p><i class="fas fa-home me-3"></i> v.pecoraro14@studenti.unisa.it
          </p>
          <p><i class="fas fa-home me-3"></i> g.mauro14@studenti.unisa.it
          </p>
        </div>
        <!-- Grid column -->
      </div>
      <!-- Grid row -->
    </div>
  </section>
  <!-- Section: Links  -->

  <!-- Copyright -->
  <div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.05);">
    © 2022 Copyright:
    <a class="text-reset fw-bold" href="https://github.com/tanucc9/SkillsFootball_Ontology">Skill Football Ontology </a>
  </div>
  <!-- Copyright -->
</footer>
<!-- Footer -->

</body>
</html>