package model.bean;
import java.util.ArrayList;
public class SkillBean {
    private String nome;
    private String tipo;
    private String descrizione;
    private int valSkill;
    private ArrayList<SoccerPlayerBean> players;
    @Override
    public String toString() {
        return "SkillBean{" +
                "nome='" + nome + '\'' +
                ", tipo='" + tipo + '\'' +
                ", descrizione='" + descrizione + '\'' +
                ", valSkill=" + valSkill +
                ", players=" + players +
                '}';
    }

    public int getValSkill() {
        return valSkill;
    }

    public void setValSkill(int valSkill) {
        this.valSkill = valSkill;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public ArrayList<SoccerPlayerBean> getPlayers() {
        return players;
    }

    public void setPlayers(ArrayList<SoccerPlayerBean> players) {
        this.players = players;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

}