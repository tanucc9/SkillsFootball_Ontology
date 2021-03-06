package control;

import model.bean.SkillBean;
import model.bean.SoccerPlayerBean;
import model.dao.SkillsFootballOntologyDAO;

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

        String uriPlayer = request.getParameter("player");
        SkillsFootballOntologyDAO sDao = new SkillsFootballOntologyDAO();

        try {
            if (uriPlayer.contains("http://www.semanticweb.org/tanucc/ontologies/2022/4/skillsFootball")) {
                uriPlayer = sDao.doRetrieveURIDBPPlayer(uriPlayer.split("skillsFootball")[1]);
            }

            uriPlayer = "<" + uriPlayer + ">";
            SoccerPlayerBean player = sDao.doSpecificPlayer(uriPlayer);
            ArrayList<SkillBean> skills = sDao.doSpecialSkillPlayer(uriPlayer);

            String uriCurrClub = "<" + player.getFootballTeamBean().getUri() + ">";
            ArrayList<SoccerPlayerBean> relatedPlayers = sDao.doRetrieveRelatedPlayers(uriCurrClub, uriPlayer);

            request.setAttribute("player", player);
            request.setAttribute("skills", skills);
            request.setAttribute("relatedPlayers", relatedPlayers);
            RequestDispatcher dispatcher = request
                    .getRequestDispatcher(response.encodeRedirectURL("./SpecificPlayer.jsp"));
            dispatcher.forward(request, response);
        } catch (Exception e) {
            // if has exception, then go to home without showing the exception.
            RequestDispatcher dispatcher = request
                    .getRequestDispatcher(response.encodeRedirectURL("./Index.jsp"));
            dispatcher.forward(request, response);
            return;
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
