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
    if (player == null) {
        response.sendRedirect("./Index.jsp");
        return;
    }%>

<!DOCTYPE html>
<html lang="it">
<head>
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

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="./styles/specificPlayer.css">
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
            <p><b>Squadra attuale:</b> <a href="<%= player.getFottballTeamBean().getUri()%>" target="_blank"><%= player.getFottballTeamBean().getName()%></a></p>
        </div>
        <div class="col-lg-6">
            <p><b>Posizione:</b> <%= player.getPosition() %></p>
        </div>
    </div>
    <h3>Abilità speciali di <%= player.getName() %></h3>
    <div class="row">
        <div></div>
        <div></div>
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
                        label: 'Skills  <%= player.getName() %>',
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