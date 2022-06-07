/* clickable cards */
var elements = document.getElementsByClassName("card_player");
var redirectToSpecificPlayer = function() {
    let uri = this.getAttribute("data-uri");
    window.location.href = "SpecificPlayer?player=" + uri;
};
for (var i = 0; i < elements.length; i++) {
    elements[i].addEventListener('click', redirectToSpecificPlayer, false);
}


/* sample images */
var cards = document.getElementsByClassName("card");
for (var i = 0; i < cards.length; i++) {
    let thumb = cards[i].getAttribute("data-thumb");
    checkImage(thumb, cards[i]);
}

function checkImage(imageSrc, card) {
    var img = new Image();
    img.onerror = function () {
        card.getElementsByTagName("img")[0].style.display="none";
        card.getElementsByTagName("img")[1].style.display="block";
    };
    img.src = imageSrc;
}


