package model.bean;

public class FootBallTeamBean {
    private String uri;
    private String name;
    private String thumbnail;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }



    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    @Override
    public String toString() {
        return "FootBallTeamBean{" +
                "uri='" + uri + '\'' +
                ", name='" + name + '\'' +
                ", thumbnail='" + thumbnail + '\'' +
                '}';
    }
}
