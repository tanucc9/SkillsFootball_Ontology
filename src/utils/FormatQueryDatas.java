package utils;

public class FormatQueryDatas {
    //@todo cercare su internet per capire che formato deve avere l'uri del thumbnail dato che attualmente quello prelevato da dbpedia non va
    public static String formatUriThumbnail(String uri) {
        uri= uri.trim();
        uri= uri.replace("commons", "en");
        uri= uri.replaceAll("(jpg/)[^&]*(px)", "$1100$2");

        return uri;
    }
}
