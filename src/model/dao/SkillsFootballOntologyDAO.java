package model.dao;

import model.bean.FootBallTeamBean;
import model.bean.SoccerPlayerBean;
import org.apache.jena.query.*;

import java.util.ArrayList;

public class SkillsFootballOntologyDAO {
    private final String endpoint = "http://localhost:3030/SkillsFootball/query";


    public ArrayList<SoccerPlayerBean> doProva() {
        ArrayList<SoccerPlayerBean> players = new ArrayList<>();


        String q = "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "\n" +
                "SELECT DISTINCT ?individual ?name ?position ?currClub ?currClubURI ?currClubThumbnail ?overall ?thumbnail\n" +
                "WHERE {\n" +
                "      SERVICE <http://dbpedia.org/sparql> {\n" +
                "    ?individual a dbo:SoccerPlayer .\n" +
                "    ?individual dbp:name ?name .\n" +
                "    ?individual dbp:currentclub ?currClubURI .\n" +
                "    ?currClubURI rdfs:label ?currClub.\n" +
                "    ?currClubURI dbo:thumbnail ?currClubThumbnail .\n" +
                "    ?individual dbo:thumbnail ?thumbnail .\n" +
                "    ?individual dbo:position ?posURI .\n" +
                "    ?posURI rdfs:label ?position .\n" +
                "    FILTER(LANG(?currClub) = 'en')\n" +
                "    FILTER(LANG(?position) = 'it')\n" +
                "  }\n" +
                "    ?player a dbo:SoccerPlayer .\n" +
                "  \t?player myonto:has_overall ?overall .\n" +
                "  \t?player rdfs:seeAlso ?individual .\n" +
                "}\n" +
                "ORDER BY DESC(?overall)\n" +
                "LIMIT 30\n" +
                "\n";

        Query query = QueryFactory.create(q);

        // Esecuzione della querye cattura dei risultati
        QueryExecution qexec = QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results = qexec.execSelect();
        while (results.hasNext()) {
            QuerySolution qSolution = results.nextSolution();
            SoccerPlayerBean player = new SoccerPlayerBean();
            FootBallTeamBean team = new FootBallTeamBean();
            player.setUri(qSolution.getResource("individual").getURI());
            player.setName(qSolution.getLiteral("name").getString());
            player.setThumbnail(qSolution.getResource("thumbnail").getURI());
            player.setPosition(qSolution.getLiteral("position").getString());
            player.setOverall(qSolution.getLiteral("overall").getInt());
            team.setUri(qSolution.getResource("currClubURI").getURI());
            team.setThumbnail(qSolution.getResource("currClubThumbnail").getURI());
            team.setName(qSolution.getLiteral("currClub").getString());
            player.setFottballTeamBean(team);
            players.add(player);
        }
        qexec.close();
        return players;
    }


    public ArrayList<SoccerPlayerBean> doRetrieveResult() {
        ArrayList<SoccerPlayerBean> result = new ArrayList<>();


        String q = "PREFIX owl: <http://www.w3.org/2002/07/owl#>\n" +
                "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "\n" +
                "SELECT DISTINCT ?special_skill ?skill_name ?skill_type  ?skill_descr (GROUP_CONCAT(?player;SEPARATOR=\",\") AS ?players)\n" +
                "(GROUP_CONCAT(?fullname;SEPARATOR=\",\") AS ?fullnames)\n" +
                "WHERE {\n" +
                "  ?special_skill a myonto:special_skills.\n" +
                "  ?special_skill myonto:special_skill_associated_to ?player.\n" +
                "  ?player dbp:fullname ?fullname.\n" +
                "  ?special_skill myonto:is_type ?skill_type.\n" +
                "  ?special_skill myonto:has_name ?skill_name.\n" +
                "  ?special_skill myonto:has_description ?skill_descr.\n" +
                "}\n" +
                "GROUP BY ?special_skill ?skill_name ?skill_type  ?skill_descr\n" +
                "ORDER BY ASC(?skill_name)\n";

        Query query = QueryFactory.create(q);

        // Esecuzione della querye cattura dei risultati
        QueryExecution qexec = QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results = qexec.execSelect();
        while (results.hasNext()) {
            QuerySolution qSolution = results.nextSolution();
            SoccerPlayerBean player = new SoccerPlayerBean();
            FootBallTeamBean team = new FootBallTeamBean();
            player.setUri(qSolution.getResource("individual").getURI());
            player.setName(qSolution.getLiteral("name").getString());
            player.setThumbnail(qSolution.getResource("thumbnail").getURI());
            player.setPosition(qSolution.getLiteral("position").getString());
            player.setOverall(qSolution.getLiteral("overall").getInt());
            team.setUri(qSolution.getResource("currClubURI").getURI());
            team.setThumbnail(qSolution.getResource("currClubThumbnail").getURI());
            team.setName(qSolution.getLiteral("currClub").getString());
            player.setFottballTeamBean(team);
            result.add(player);
        }
        qexec.close();
        return result;
    }
}
