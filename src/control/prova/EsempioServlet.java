package control.prova;

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
@WebServlet("/EsempioServlet")
public class EsempioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public EsempioServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String nomeAttr = request.getParameter("nomeAttr");
		request.setAttribute("x", nomeAttr);

		SkillsFootballOntologyDAO pdao = new SkillsFootballOntologyDAO();
		ArrayList<SoccerPlayerBean> a = pdao.doProva();
		LoggerSingleton l = LoggerSingleton.getInstance();
		for(SoccerPlayerBean socc : a){
			l.debug(socc.toString());
		}

		RequestDispatcher dispatcher = request
                .getRequestDispatcher(response.encodeRedirectURL("./Index.jsp"));
      dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
