package model.dao;

import java.util.ArrayList;

import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QuerySolution;
import org.apache.jena.query.ResultSet;
import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.Resource;
import utils.LoggerSingleton;

public class ProvaDAO {

    private final String endpoint= "http://localhost:3030/SkillsFootball/query";
    public void doProva() {

        String q="PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "SELECT * WHERE {   ?sub ?pred ?obj . } LIMIT 10";

        Query query= QueryFactory.create(q);
        // Esecuzione della querye cattura dei risultati
        QueryExecution qexec= QueryExecutionFactory.sparqlService(endpoint, query);
        ResultSet results= qexec.execSelect();
        while(results.hasNext()) {
            QuerySolution soln= results.nextSolution();
            LoggerSingleton log = LoggerSingleton.getInstance();
            Resource r = soln.getResource("pred");

            log.debug(soln.getLiteral("obj").toString());
            log.debug(r.toString());
        }
        qexec.close();
    }
}