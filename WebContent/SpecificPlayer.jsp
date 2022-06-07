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
    if (player == null || skills == null) {
        response.sendRedirect("./Index.jsp");
        return;
    }%>

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
            <p><b>Squadra attuale:</b> <a href="<%= player.getFottballTeamBean().getUri()%>" target="_blank"><%= player.getFottballTeamBean().getName()%></a></p>
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
            <p><b><%= skill.getNome() %></b>: <%= skill.getDescrizione() %></p>
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
<jsp:include page="./parts/footer.jsp" />
<!-- Footer -->

</body>
</html>