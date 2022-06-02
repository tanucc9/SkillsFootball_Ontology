package control.prova;

import model.bean.FootBallTeamBean;
import model.bean.SkillBean;
import model.bean.SoccerPlayerBean;
import model.dao.SkillsFootballOntologyDAO;
import utils.LoggerSingleton;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EsempioServlet
 */
@WebServlet("/SpecificPlayer")
public class SpecificPlayerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    public SpecificPlayerServlet() {
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //@todo edit mock uriPlayer
        String uriPlayer = "<http://dbpedia.org/resource/Ángel_Correa>";

        SkillsFootballOntologyDAO sDao = new SkillsFootballOntologyDAO();
        SoccerPlayerBean player = sDao.doSpecificPlayer(uriPlayer);
        ArrayList<SkillBean> skills = sDao.doSpecialSkillPlayer(uriPlayer);

        LoggerSingleton l = LoggerSingleton.getInstance();
        l.debug(player.toString());

        request.setAttribute("player", player);
        request.setAttribute("skills", skills);
        RequestDispatcher dispatcher = request
                .getRequestDispatcher(response.encodeRedirectURL("./SpecificPlayer.jsp"));
        dispatcher.forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
