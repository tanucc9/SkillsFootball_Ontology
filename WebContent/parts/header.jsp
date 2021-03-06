<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="/SkillsFootballOntology">Skills Football Ontology</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link <% if (request.getRequestURI().equals("/SkillsFootballOntology/")) { %>active<% } %>" aria-current="page" href="/SkillsFootballOntology">Lista calciatori</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <% if (request.getRequestURI().equals("/SkillsFootballOntology/BallonDOR.jsp")) { %>active<% } %>" href="/SkillsFootballOntology/BallonDOR.jsp">Pallone d'oro</a>
                </li>
            </ul>
        </div>
    </div>
</nav>