package model.dao;

import model.bean.FootBallTeamBean;
import model.bean.SkillBean;
import model.bean.SoccerPlayerBean;
import org.apache.jena.query.*;

import java.util.ArrayList;
import java.util.HashMap;

public class SkillsFootballOntologyDAO {
    private final String endpoint = "http://localhost:3030/SkillsFootball/query";


    public ArrayList<SoccerPlayerBean>  doRetrieveBest30SoccerPlayerInTheWorld() {
        ArrayList<SoccerPlayerBean> players = new ArrayList<>();

        String q = "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "SELECT DISTINCT ?individual ?name ?currClub ?currClubURI ?currClubThumbnail ?overall ?thumbnail (GROUP_CONCAT(?position;SEPARATOR=\",\") AS ?positions)\n" +
                "WHERE {\n" +
                "\tSERVICE <http://dbpedia.org/sparql> {\n" +
                "      ?individual a dbo:SoccerPlayer .\n" +
                "      ?individual dbp:name ?name .\n" +
                "      ?individual dbp:currentclub ?currClubURI .\n" +
                "      ?currClubURI rdfs:label ?currClub.\n" +
                "      ?currClubURI dbo:thumbnail ?currClubThumbnail .\n" +
                "      ?individual dbo:thumbnail ?thumbnail .\n" +
                "      ?individual dbo:position ?posURI .\n" +
                "      ?posURI rdfs:label ?position .\n" +
                "      FILTER(LANG(?currClub) = 'en')\n" +
                "      FILTER(LANG(?position) = 'it')\n" +
                "\t}\n" +
                "    ?player a dbo:SoccerPlayer .\n" +
                "    ?player myonto:has_overall ?overall .\n" +
                "    ?player rdfs:seeAlso ?individual .\n" +
                "}\n" +
                "GROUP BY ?individual ?name ?currClub ?currClubURI ?currClubThumbnail ?overall ?thumbnail\n" +
                "ORDER BY DESC(?overall)\n" +
                "LIMIT 30";

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
            player.setPosition(qSolution.getLiteral("positions").getString());
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

    public ArrayList<FootBallTeamBean> doRetrieveStatsFootballTeamWithMaxAvgAndMinimunOverall() {
        ArrayList<FootBallTeamBean> result = new ArrayList<>();


        String q = "PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>\n" +
                "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "\n" +
                "SELECT DISTINCT ?currClubURI ?clubn ?currClubThumbnail (CEIL(AVG(?overall)) AS ?avg_overall) (MIN(?overall) AS ?min_overall) (MAX(?overall) AS ?max_overall) \n" +
                "WHERE {\n" +
                "      SERVICE <http://dbpedia.org/sparql> {\n" +
                "    ?individual a dbo:SoccerPlayer .\n" +
                "    ?individual dbp:currentclub ?currClubURI .\n" +
                "    ?currClubURI dbo:thumbnail ?currClubThumbnail .\n" +
                "    ?currClubURI dbp:clubname ?clubn.\n" +
                "  }\n" +
                "    ?player a dbo:SoccerPlayer .\n" +
                "  \t?player myonto:has_overall ?overall .\n" +
                "  \t?player rdfs:seeAlso ?individual .\n" +
                "}\n" +
                "GROUP BY ?currClubURI ?currClubThumbnail ?clubn\n" +
                "HAVING (MAX(?overall) != MIN(?overall))\n" +
                "ORDER BY DESC(?avg_overall)\n" +
                "LIMIT 30\n";

        Query query = QueryFactory.create(q);

        // Esecuzione della querye cattura dei risultati
        QueryExecution qexec = QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results = qexec.execSelect();
        while (results.hasNext()) {
            FootBallTeamBean iTeam = new FootBallTeamBean();
            QuerySolution qSolution = results.nextSolution();
            iTeam.setUri(qSolution.getResource("currClubURI").getURI());
            iTeam.setName(qSolution.getLiteral("clubn").getString());
            iTeam.setThumbnail(qSolution.getResource("currClubThumbnail").getURI());
            iTeam.setAvg_overall(qSolution.getLiteral("avg_overall").getInt());
            iTeam.setMax_overall(qSolution.getLiteral("max_overall").getInt());
            iTeam.setMin_overall(qSolution.getLiteral("min_overall").getInt());
            result.add(iTeam);
        }
        qexec.close();
        return result;
    }
    public ArrayList<SkillBean> doRetrieveSpecialSkillsWithNameAndResourceSoccerPlayer() {
        ArrayList<SkillBean> result = new ArrayList<>();

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
            SkillBean skill_row = new SkillBean();
            QuerySolution qSolution = results.nextSolution();
            ArrayList<SoccerPlayerBean> soccerPlayers = new ArrayList<>();
            String[] resource = qSolution.getLiteral("players").getString().split(",");
            String[] full_name = qSolution.getLiteral("fullnames").getString().split(",");
            for(int i=0; i<resource.length;i++){
                SoccerPlayerBean iPlayer = new SoccerPlayerBean();
                iPlayer.setUri(resource[i]);
                iPlayer.setName(full_name[i]);
                soccerPlayers.add(i,iPlayer);
            }
            skill_row.setPlayers(soccerPlayers);
            skill_row.setNome(qSolution.getLiteral("skill_name").getString());
            skill_row.setTipo(qSolution.getLiteral("skill_type").getString());
            skill_row.setDescrizione(qSolution.getLiteral("skill_descr").getString());
            result.add(skill_row);

        }
        qexec.close();
        return result;
    }

    public ArrayList<SoccerPlayerBean> doRetrieveBallonDOr() {
        ArrayList<SoccerPlayerBean> result = new ArrayList<>();


        String q = "PREFIX dct: <http://purl.org/dc/terms/>\n" +
                "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "\n" +
                "SELECT DISTINCT ?individual ?name ?position ?currClub ?currClubURI ?currClubThumbnail ?overall ?thumbnail_player ?label_ballondor ?comment_ballondor\n" +
                "WHERE {\n" +
                "      SERVICE <http://dbpedia.org/sparql> {\n" +
                "    ?individual a dbo:SoccerPlayer .\n" +
                "    ?individual dbp:name ?name .\n" +
                "    ?individual dbp:currentclub ?currClubURI .\n" +
                "    ?currClubURI rdfs:label ?currClub.\n" +
                "    ?currClubURI dbo:thumbnail ?currClubThumbnail .\n" +
                "    ?individual dbo:thumbnail ?thumbnail_player .\n" +
                "    ?individual dbo:position ?posURI .\n" +
                "    ?posURI rdfs:label ?position .\n" +
                "    ?individual dbo:wikiPageWikiLink <http://dbpedia.org/resource/Category:Ballon_d'Or_winners>.\n" +
                "    ?individual dbo:wikiPageWikiLink ?ballondor .\n" +
                "    ?ballondor rdfs:comment ?comment_ballondor.\n" +
                "    ?ballondor rdfs:label ?label_ballondor.\n" +
                "    FILTER(LANG(?currClub) = 'en')\n" +
                "    FILTER(LANG(?position) = 'it')\n" +
                "    FILTER(LANG(?comment_ballondor) = 'it')\n" +
                "    FILTER(LANG(?label_ballondor) = 'it')\n" +
                "    FILTER(?ballondor = <http://dbpedia.org/resource/FIFA_Ballon_d'Or>)\n" +
                "  }\n" +
                "    ?player a dbo:SoccerPlayer .\n" +
                "  \t?player myonto:has_overall ?overall .\n" +
                "  \t?player rdfs:seeAlso ?individual .\n" +
                "}\n" +
                "ORDER BY DESC(?overall)\n" +
                "LIMIT 30\n";

        Query query = QueryFactory.create(q);

        // Esecuzione della querye cattura dei risultati
        QueryExecution qexec = QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results = qexec.execSelect();
        while (results.hasNext()) {
            QuerySolution qSolution = results.nextSolution();
            SoccerPlayerBean spCurrent = new SoccerPlayerBean();
            FootBallTeamBean ftCurrent = new FootBallTeamBean();
            spCurrent.setUri(qSolution.getResource("individual").getURI());
            spCurrent.setName(qSolution.getLiteral("name").getString());
            spCurrent.setPosition(qSolution.getLiteral("position").getString());
            ftCurrent.setName(qSolution.getLiteral("currClub").getString());
            ftCurrent.setUri(qSolution.getResource("currClubURI").getURI());
            ftCurrent.setThumbnail(qSolution.getResource("currClubThumbnail").getURI());
            spCurrent.setFottballTeamBean(ftCurrent);
            spCurrent.setOverall(qSolution.getLiteral("overall").getInt());
            spCurrent.setThumbnail(qSolution.getResource("thumbnail_player").getURI());
            spCurrent.setLabel_BallonDOr(qSolution.getLiteral("label_ballondor").getString());
            spCurrent.setComment_BallonDOr(qSolution.getLiteral("comment_ballondor").getString());
            result.add(spCurrent);
        }
        qexec.close();
        return result;
    }

    public SoccerPlayerBean doSpecificPlayer(String resourcePlayer) {

        SoccerPlayerBean player = new SoccerPlayerBean();
        FootBallTeamBean team = new FootBallTeamBean();
        ArrayList<SkillBean> skills = new ArrayList<SkillBean>();

        String q = "PREFIX owl: <http://www.w3.org/2002/07/owl#>\n" +
                "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "\n" +
                "SELECT DISTINCT ?name (GROUP_CONCAT(?position;SEPARATOR=\",\") AS ?positions) ?currClub ?currClubURI ?currClubThumbnail ?thumbnail ?stats ?name_stat ?stats_individual ?comment ?type_stat ?descr_stat \n" +
                "WHERE {\n" +
                "  {\n" +
                "    SERVICE <http://dbpedia.org/sparql> {\n" +
                "    " + resourcePlayer + " dbp:name ?name .\n" +
                "    " + resourcePlayer + " dbp:currentclub ?currClubURI .\n" +
                "    " + resourcePlayer + "rdfs:comment ?comment ." +
                "    ?currClubURI rdfs:label ?currClub.\n" +
                "    ?currClubURI dbo:thumbnail ?currClubThumbnail .\n" +
                "    " + resourcePlayer + " dbo:thumbnail ?thumbnail .\n" +
                "    " + resourcePlayer + " dbo:position ?posURI .\n" +
                "    ?posURI rdfs:label ?position .\n" +
                "    FILTER(LANG(?currClub) = 'it')\n" +
                "    FILTER(LANG(?position) = 'it')\n" +
                "    FILTER(LANG(?comment) = 'it')" +
                "    }\n" +
                "}\n" +
                "  UNION\n" +
                "  {\n" +
                "    ?player a dbo:SoccerPlayer .\n" +
                "  \t?player ?p ?stats .\n" +
                "  \t?p rdfs:seeAlso ?stats_individual.\n" +
                "  \t?stats_individual myonto:has_name ?name_stat .\n" +
                "   ?stats_individual myonto:is_type ?type_stat .\n" +
                "   ?stats_individual myonto:has_description ?descr_stat .\n" +
                "  \t?player rdfs:seeAlso " + resourcePlayer + " .\n" +
                "}\n" +
                "}\n " +
                "GROUP BY ?name ?currClub ?currClubURI ?currClubThumbnail ?thumbnail ?stats ?name_stat ?stats_individual ?comment ?type_stat ?descr_stat\n" +
                "ORDER BY DESC(?name)\n";

        Query query = QueryFactory.create(q);

        QueryExecution qexec = QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results = qexec.execSelect();
        while (results.hasNext()) {
            QuerySolution qSolution = results.nextSolution();
            if (qSolution.getLiteral("name") == null) {
                SkillBean skill = new SkillBean();
                skill.setNome(qSolution.getLiteral("name_stat").getString());
                skill.setTipo(qSolution.getLiteral("type_stat").getString());
                skill.setDescrizione(qSolution.getLiteral("descr_stat").getString());
                skill.setValSkill(qSolution.getLiteral("stats").getInt());
                skill.setUri(qSolution.getResource("stats_individual").getURI());
                skills.add(skill);
            } else {
                player.setName(qSolution.getLiteral("name").getString());
                player.setPosition(qSolution.getLiteral("positions").getString());
                team.setName(qSolution.getLiteral("currClub").getString());
                team.setUri(qSolution.getResource("currClubURI").getURI());
                team.setThumbnail(qSolution.getResource("currClubThumbnail").getURI());
                player.setThumbnail(qSolution.getResource("thumbnail").getURI());
                player.setComment(qSolution.getLiteral("comment").getString());
                player.setFottballTeamBean(team);
            }
        }
        qexec.close();

        player.setSkills(skills);

        return player;
    }

    public ArrayList<SkillBean> doSpecialSkillPlayer(String resourcePlayer) {

        SoccerPlayerBean player = new SoccerPlayerBean();
        FootBallTeamBean team = new FootBallTeamBean();
        ArrayList<SkillBean> skills = new ArrayList<SkillBean>();

        String q = "PREFIX owl: <http://www.w3.org/2002/07/owl#>\n" +
                "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "\n" +
                "SELECT DISTINCT ?player (GROUP_CONCAT(?special_skillURI;SEPARATOR=\",\") AS ?special_skills_uri) (GROUP_CONCAT(?special_skill;SEPARATOR=\",\") AS ?special_skills) (GROUP_CONCAT(?special_skill_descr;SEPARATOR=\"§\") AS ?special_skills_descr)\n" +
                "WHERE {\n" +
                "  ?player a dbo:SoccerPlayer .\n" +
                "  ?player rdfs:seeAlso " + resourcePlayer + ".\n" +
                "  ?player myonto:has_special_skill ?special_skillURI .\n" +
                "  ?special_skillURI myonto:has_name ?special_skill .\n" +
                "  ?special_skillURI myonto:has_description ?special_skill_descr .\n" +
                "}\n" +
                "GROUP BY ?player";

        Query query = QueryFactory.create(q);

        QueryExecution qexec = QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results = qexec.execSelect();
        while (results.hasNext()) {
            QuerySolution qSolution = results.nextSolution();


            String skillNames = qSolution.getLiteral("special_skills").getString();
            String skillDescrs = qSolution.getLiteral("special_skills_descr").getString();
            String skillUris = qSolution.getLiteral("special_skills_uri").getString();

            String[] splittedSkillNames = skillNames.split(",");
            String[] splittedSkillUris = skillUris.split(",");
            String[] splittedSkillDescrs = skillDescrs.split("§");
            for (int i = 0; splittedSkillNames.length > i; i++) {
                SkillBean skill = new SkillBean();
                skill.setNome(splittedSkillNames[i]);
                skill.setDescrizione(splittedSkillDescrs[i]);
                skill.setUri(splittedSkillUris[i]);
                skills.add(skill);
            }
        }
        qexec.close();

        return skills;
    }

    public String doRetrieveURIDBPPlayer(String resourcePlayerMyOnto) {

        String q = "PREFIX owl: <http://www.w3.org/2002/07/owl#>\n" +
                "PREFIX db: <http://dbpedia.org/>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX dbo: <http://dbpedia.org/ontology/>\n" +
                "PREFIX dbp: <http://dbpedia.org/property/>\n" +
                "PREFIX myonto: <http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball>\n" +
                "\n" +
                "SELECT DISTINCT ?player \n" +
                "WHERE {\n" +
                "    myonto:" + resourcePlayerMyOnto + " rdfs:seeAlso ?player .\n" +
                "}";

        Query query = QueryFactory.create(q);

        QueryExecution qexec = QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results = qexec.execSelect();
        while (results.hasNext()) {
            QuerySolution qSolution = results.nextSolution();
            return qSolution.getResource("player").getURI();
        }
        qexec.close();

        return null;
    }

}
