var elements = document.getElementsByClassName("card_player");

var redirectToSpecificPlayer = function() {
    let uri = this.getAttribute("data-uri");
    window.location.href = "SpecificPlayer?player=" + uri;
};

for (var i = 0; i < elements.length; i++) {
    elements[i].addEventListener('click', redirectToSpecificPlayer, false);
}

